part of 'login_bloc.dart';

@freezed
class LoginEvent extends BaseEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;

  const factory LoginEvent.sendOtpClicked({
    required String phoneNumber,
  }) = _SendOtpClicked;
}
