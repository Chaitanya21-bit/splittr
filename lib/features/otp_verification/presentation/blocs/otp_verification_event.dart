part of 'otp_verification_bloc.dart';

@freezed
class OtpVerificationEvent extends BaseEvent with _$OtpVerificationEvent {
  const factory OtpVerificationEvent.started({
    String? phoneNumber,
    String? verificationId,
    int? forceResendingToken,
  }) = _Started;

  const factory OtpVerificationEvent.otpChanged({
    required String otp,
  }) = _OtpChanged;

  const factory OtpVerificationEvent.verifyButtonClicked() =
      _VerifyButtonClicked;
}
