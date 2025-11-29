part of 'auth_landing_bloc.dart';

@freezed
class AuthLandingEvent extends BaseEvent with _$AuthLandingEvent {
  const AuthLandingEvent._();

  const factory AuthLandingEvent.started() = _Started;
}
