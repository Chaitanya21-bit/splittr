import 'dart:async';

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
    on<_SendOtp>(_onSendOtp);
  }

  void _onStarted(_Started event, Emitter<LoginState> emit) {}

  Future<void> _onSendOtpClicked(
    _SendOtpClicked event,
    Emitter<LoginState> emit,
  ) async {
    if (event.phoneNumber.isEmpty || event.phoneNumber.length != 10) {
      return;
    }

    changeLoaderState(emit: emit, loading: true);

    await _authRepository.sendOtp(
      event.phoneNumber,
      (verificationId, forceResendingToken) {
        add(
          LoginEvent.sendOtp(
            verificationId: verificationId,
            forceResendingToken: forceResendingToken,
          ),
        );
      },
    );
  }

  void _onSendOtp(_SendOtp event, Emitter<LoginState> emit) {
    emit(
      LoginState.otpSent(
        store: state.store.copyWith(
          loading: false,
        ),
        verificationId: event.verificationId,
        forceResendingToken: event.forceResendingToken,
      ),
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

  void sendOtp({
    required String verificationId,
    int? forceResendingToken,
  }) {
    add(
      LoginEvent.sendOtp(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken,
      ),
    );
  }

  @override
  bool get isLoading => state.store.loading;
}
