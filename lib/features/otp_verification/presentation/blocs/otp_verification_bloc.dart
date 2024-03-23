import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'otp_verification_bloc.freezed.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

@injectable
final class OtpVerificationBloc
    extends BaseBloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc()
      : super(
          const OtpVerificationState.initial(
            store: OtpVerificationStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_OtpChanged>(_onOtpChanged);
    on<_VerifyButtonClicked>(_onVerifyButtonClicked);
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

  void _onVerifyButtonClicked(
    _,
    Emitter<OtpVerificationState> emit,
  ) {

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
}
