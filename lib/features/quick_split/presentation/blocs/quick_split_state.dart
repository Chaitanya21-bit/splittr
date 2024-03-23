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
  }) = _QuickSplitStateStore;
}
