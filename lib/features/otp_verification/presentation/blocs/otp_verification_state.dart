part of 'otp_verification_bloc.dart';

@freezed
sealed class OtpVerificationState extends BaseState
    with _$OtpVerificationState {
  const OtpVerificationState._();

  const factory OtpVerificationState.initial({
    required OtpVerificationStateStore store,
  }) = Initial;

  const factory OtpVerificationState.changeLoaderState({
    required OtpVerificationStateStore store,
  }) = ChangeLoaderState;

  const factory OtpVerificationState.onException({
    required OtpVerificationStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      OtpVerificationState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      OtpVerificationState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class OtpVerificationStateStore with _$OtpVerificationStateStore {
  const factory OtpVerificationStateStore({
    String? verificationId,
    int? forceResendingToken,
    @Default(false) bool loading,
  }) = _OtpVerificationStateStore;
}
