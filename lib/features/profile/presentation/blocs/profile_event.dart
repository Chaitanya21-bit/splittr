part of 'profile_bloc.dart';

@freezed
class ProfileEvent extends BaseEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
}
