part of 'profile_bloc.dart';

@freezed
class ProfileEvent extends BaseEvent with _$ProfileEvent {
  const ProfileEvent._();

  const factory ProfileEvent.started() = _Started;
}
