part of 'transactions_bloc.dart';

@freezed
sealed class TransactionsState extends BaseState with _$TransactionsState {
  const TransactionsState._();

  const factory TransactionsState.initial({
    required TransactionsStateStore store,
  }) = Initial;

  const factory TransactionsState.changeLoaderState({
    required TransactionsStateStore store,
  }) = ChangeLoaderState;

  const factory TransactionsState.onFailure({
    required TransactionsStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      TransactionsState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      TransactionsState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class TransactionsStateStore with _$TransactionsStateStore {
  const factory TransactionsStateStore({
    @Default(false) bool loading,
  }) = _TransactionsStateStore;
}
