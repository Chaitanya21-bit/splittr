part of 'quick_settle_bloc.dart';

@freezed
sealed class QuickSettleState extends BaseState with _$QuickSettleState {
  const QuickSettleState._();

  const factory QuickSettleState.initial({
    required QuickSettleStateStore store,
  }) = Initial;

  const factory QuickSettleState.changeLoaderState({
    required QuickSettleStateStore store,
  }) = ChangeLoaderState;

  const factory QuickSettleState.onFailure({
    required QuickSettleStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      QuickSettleState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      QuickSettleState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class QuickSettleStateStore with _$QuickSettleStateStore {
  const factory QuickSettleStateStore({
    @Default(false) bool loading,
  }) = _QuickSettleStateStore;
}
