part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent extends BaseEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
}
