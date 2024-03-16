part of 'quick_split_bloc.dart';

@freezed
class QuickSplitEvent extends BaseEvent with _$QuickSplitEvent {
  const factory QuickSplitEvent.started() = _Started;
}
