part of 'quick_settle_bloc.dart';

@freezed
class QuickSettleEvent extends BaseEvent with _$QuickSettleEvent {
  const factory QuickSettleEvent.started() = _Started;
}
