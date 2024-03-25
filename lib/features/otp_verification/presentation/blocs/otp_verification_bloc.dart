import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/core/user/domain/domain/repositories/i_user_repository.dart';
import 'package:splittr/core/user/domain/models/user.dart';

part 'otp_verification_bloc.freezed.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

@injectable
final class OtpVerificationBloc
    extends BaseBloc<OtpVerificationEvent, OtpVerificationState> {
  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  OtpVerificationBloc(
    this._authRepository,
    this._userRepository,
  ) : super(
          const OtpVerificationState.initial(
            store: OtpVerificationStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_OtpChanged>(_onOtpChanged);
    on<_VerifyButtonClicked>(_onVerifyButtonClicked);
    on<_OtpVerified>(_onOtpVerified);
  }

  void _onStarted(
    _Started event,
    Emitter<OtpVerificationState> emit,
  ) {
    emit(
      OtpVerificationState.initial(
        store: state.store.copyWith(
          phoneNumber: event.phoneNumber,
          verificationId: event.verificationId,
          forceResendingToken: event.forceResendingToken,
        ),
      ),
    );
  }

  void _onOtpChanged(
    _OtpChanged event,
    Emitter<OtpVerificationState> emit,
  ) {
    emit(
      OtpVerificationState.otpChange(
        store: state.store.copyWith(
          otp: event.otp,
        ),
      ),
    );
  }

  Future<void> _onVerifyButtonClicked(
    _,
    Emitter<OtpVerificationState> emit,
  ) async {
    final otp = state.store.otp;
    if (otp?.length != 6) {
      return;
    }

    changeLoaderState(emit: emit, loading: true);

    final verifyOtpOrFailure = await _authRepository.verifyOtp(
      otp: otp ?? '',
      verificationId: state.store.verificationId ?? '',
    );

    verifyOtpOrFailure.fold(
      (failure) => handleFailure(
        emit: emit,
        failure: failure,
      ),
      (_) => otpVerified(),
    );
  }

  Future<void> _onOtpVerified(
    _,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(
      OtpVerificationState.verifiedOtp(
        store: state.store,
      ),
    );

    final userOrFailure =
        await _userRepository.fetchUser(_authRepository.userId ?? '');

    await userOrFailure.fold<Future<void>>(
      (failure) async {
        final userSavedOrFailure = await _userRepository.saveUser(
          User(
            userId: _authRepository.userId,
            phoneNo: state.store.phoneNumber,
          ),
        );

        userSavedOrFailure.fold(
          (failure) => handleFailure(emit: emit, failure: failure),
          (user) => emit(
            OtpVerificationState.userAuthenticateSuccessful(
              store: state.store.copyWith(loading: false),
              user: user,
            ),
          ),
        );
      },
      (user) async => emit(
        OtpVerificationState.userAuthenticateSuccessful(
          store: state.store.copyWith(loading: false),
          user: user,
        ),
      ),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    final phoneNumber = args?[StringConstants.phoneNumber] as String?;
    final verificationId = args?[StringConstants.verificationId] as String?;
    final forceResendingToken =
        args?[StringConstants.forceResendingToken] as int?;

    add(
      OtpVerificationEvent.started(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        forceResendingToken: forceResendingToken,
      ),
    );
  }

  @override
  bool get isLoading => state.store.loading;

  void otpChanged(String otp) {
    add(OtpVerificationEvent.otpChanged(otp: otp));
  }

  void verifyButtonClicked() {
    add(const OtpVerificationEvent.verifyButtonClicked());
  }

  void otpVerified() {
    add(const OtpVerificationEvent.otpVerified());
  }
}
