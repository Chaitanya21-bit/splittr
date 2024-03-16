part of 'group_dashboard_bloc.dart';

@freezed
class GroupDashboardEvent extends BaseEvent with _$GroupDashboardEvent {
  const factory GroupDashboardEvent.started() = _Started;
}
