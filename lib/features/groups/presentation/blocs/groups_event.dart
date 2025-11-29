part of 'groups_bloc.dart';

@freezed
class GroupsEvent extends BaseEvent with _$GroupsEvent {
  const GroupsEvent._();

  const factory GroupsEvent.started() = _Started;
}
