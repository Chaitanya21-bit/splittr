import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/i_auth_repository.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
final class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final IAuthRepository _authRepository;

  LoginBloc(this._authRepository)
      : super(
          const LoginState.initial(
            store: LoginStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_SendOtpClicked>(_onSendOtpClicked);
  }

  void _onStarted(_Started event, Emitter<LoginState> emit) {}

  void _onSendOtpClicked(_SendOtpClicked event, Emitter<LoginState> emit) {
    if (event.phoneNumber.isEmpty || event.phoneNumber.length != 10) {
      return;
    }
    _authRepository.sendOtp(
      event.phoneNumber,
      (verificationId, forceResendingToken) {
        emit(
          LoginState.otpSent(
            store: state.store,
            verificationId: verificationId,
            forceResendingToken: forceResendingToken,
          ),
        );
      },
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const LoginEvent.started());
  }

  void sendOtpClicked(String phoneNumber) {
    add(
      LoginEvent.sendOtpClicked(phoneNumber: phoneNumber),
    );
  }
}
