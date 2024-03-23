part of 'otp_verification_bloc.dart';

@freezed
sealed class OtpVerificationState extends BaseState
    with _$OtpVerificationState {
  const OtpVerificationState._();

  const factory OtpVerificationState.initial({
    required OtpVerificationStateStore store,
  }) = Initial;

  const factory OtpVerificationState.otpChange({
    required OtpVerificationStateStore store,
  }) = OtpChange;

  const factory OtpVerificationState.verifiedOtp({
    required OtpVerificationStateStore store,
  }) = VerifiedOtp;

  const factory OtpVerificationState.changeLoaderState({
    required OtpVerificationStateStore store,
  }) = ChangeLoaderState;

  const factory OtpVerificationState.onFailure({
    required OtpVerificationStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      OtpVerificationState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
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
    String? phoneNumber,
    String? verificationId,
    int? forceResendingToken,
    String? otp,
    @Default(false) bool loading,
  }) = _OtpVerificationStateStore;
}
