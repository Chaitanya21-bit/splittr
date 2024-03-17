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

  const factory TransactionsState.onException({
    required TransactionsStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      TransactionsState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
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
