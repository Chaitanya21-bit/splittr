part of 'login_bloc.dart';

@freezed
sealed class LoginState extends BaseState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial({
    required LoginStateStore store,
  }) = Initial;

  const factory LoginState.otpSent({
    required LoginStateStore store,
    required String verificationId,
    int? forceResendingToken,
  }) = OtpSent;

  const factory LoginState.changeLoaderState({
    required LoginStateStore store,
  }) = ChangeLoaderState;

  const factory LoginState.onException({
    required LoginStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      LoginState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      LoginState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class LoginStateStore with _$LoginStateStore {
  const factory LoginStateStore({
    @Default(false) bool loading,
  }) = _LoginStateStore;
}
