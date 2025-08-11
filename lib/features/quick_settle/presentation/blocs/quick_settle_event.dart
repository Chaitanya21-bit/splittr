part of 'quick_settle_bloc.dart';

@freezed
class QuickSettleEvent extends BaseEvent with _$QuickSettleEvent {
  const QuickSettleEvent._();

  const factory QuickSettleEvent.started({
    required List<({double amount, String name})> peopleRecord,
  }) = _Started;
  const factory QuickSettleEvent.calculateTransactions() =
      _CalculateTransactions;

  const factory QuickSettleEvent.toggleListView() = _ToggleListView;
}
