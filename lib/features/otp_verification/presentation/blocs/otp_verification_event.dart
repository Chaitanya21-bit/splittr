part of 'otp_verification_bloc.dart';

@freezed
class OtpVerificationEvent extends BaseEvent with _$OtpVerificationEvent {
  const factory OtpVerificationEvent.started() = _Started;
}
