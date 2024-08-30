part of 'quick_split_bloc.dart';

@freezed
class QuickSplitEvent extends BaseEvent with _$QuickSplitEvent {
  const factory QuickSplitEvent.started() = _Started;
  const factory QuickSplitEvent.addPerson() = _AddPerson;

  const factory QuickSplitEvent.deletePerson({required int index}) =
      _DeletePerson;

  const factory QuickSplitEvent.nameChanged({
    required String name,
    required int index,
  }) = _NameChanged;

  const factory QuickSplitEvent.amountChanged({
    required String amount,
    required int index,
  }) = _AmountChanged;

  const factory QuickSplitEvent.quickSettleClicked() = _QuickSettleClicked;
}
