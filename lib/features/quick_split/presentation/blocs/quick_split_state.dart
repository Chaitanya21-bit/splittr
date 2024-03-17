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

  const factory QuickSplitState.onException({
    required QuickSplitStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      QuickSplitState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
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
