part of 'login_bloc.dart';

@freezed
class LoginEvent extends BaseEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;

  const factory LoginEvent.phoneNumberChanged({
    required String phoneNumber,
  }) = _PhoneNumberChanged;

  const factory LoginEvent.sendOtpClicked() = _SendOtpClicked;

  const factory LoginEvent.verificationFailed({
    required String errorMessage,
  }) = _VerificationFailed;

  const factory LoginEvent.otpCreated({
    required String verificationId,
    int? forceResendingToken,
  }) = _OtpCreated;
}
