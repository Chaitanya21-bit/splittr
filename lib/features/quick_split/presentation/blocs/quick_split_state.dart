part of 'quick_split_bloc.dart';

@freezed
sealed class QuickSplitState extends BaseState with _$QuickSplitState {
  const QuickSplitState._();

  const factory QuickSplitState.initial({
    required QuickSplitStateStore store,
  }) = Initial;

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

  const factory QuickSplitState.quickSettle({
    required QuickSplitStateStore store,
  }) = QuickSettle;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      QuickSplitState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      QuickSplitState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class QuickSplitStateStore with _$QuickSplitStateStore {
  const factory QuickSplitStateStore({
    @Default(false) bool loading,
    @Default([
      (name: '', amount: 0),
      (name: '', amount: 0),
    ])
    List<({String name, double amount})> peopleRecord,
  }) = _QuickSplitStateStore;
}
