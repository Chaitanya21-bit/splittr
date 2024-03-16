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

  const factory QuickSettleState.onException({
    required QuickSettleStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      QuickSettleState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      QuickSettleState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class QuickSettleStateStore with _$QuickSettleStateStore {
  const factory QuickSettleStateStore({
    @Default(false) bool loading,
  }) = _QuickSettleStateStore;
}
