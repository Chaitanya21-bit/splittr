part of 'quick_split_bloc.dart';

@freezed
sealed class QuickSplitState extends BaseState with _$QuickSplitState {
  const QuickSplitState._();

  const factory QuickSplitState.initial({required QuickSplitStateStore store}) =
      Initial;

  const factory QuickSplitState.changeLoaderState({
    required QuickSplitStateStore store,
  }) = ChangeLoaderState;

  const factory QuickSplitState.onFailure({
    required QuickSplitStateStore store,
    required Failure failure,
  }) = OnFailure;

  const factory QuickSplitState.nameChange({
    required QuickSplitStateStore store,
  }) = NameChange;

  const factory QuickSplitState.amountChange({
    required QuickSplitStateStore store,
  }) = AmountChange;

  const factory QuickSplitState.addedPerson({
    required QuickSplitStateStore store,
  }) = AddedPerson;

  const factory QuickSplitState.deletedPerson({
    required QuickSplitStateStore store,
  }) = DeletedPerson;

  const factory QuickSplitState.invalidAmount({
    required QuickSplitStateStore store,
    required String invalidAmount,
  }) = InvalidAmount;

  const factory QuickSplitState.emptyName({
    required QuickSplitStateStore store,
  }) = EmptyName;

  const factory QuickSplitState.quickSettle({
    required QuickSplitStateStore store,
  }) = QuickSettle;

  @override
  BaseState getFailureState(Failure failure) => QuickSplitState.onFailure(
    store: store.copyWith(loading: false),
    failure: failure,
  );

  @override
  BaseState getLoaderState({required bool loading}) =>
      QuickSplitState.changeLoaderState(
        store: store.copyWith(loading: loading),
      );
}

@freezed
class QuickSplitStateStore with _$QuickSplitStateStore {
  const QuickSplitStateStore({
    this.loading = false,
    this.peopleRecords = const [(name: '', amount: ''), (name: '', amount: '')],
  });

  @override
  final bool loading;

  @override
  final List<({String name, String amount})> peopleRecords;
}
