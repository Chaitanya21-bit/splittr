part of 'personal_transaction_bloc.dart';

@freezed
sealed class PersonalTransactionState extends BaseState
    with _$PersonalTransactionState {
  const PersonalTransactionState._();

  const factory PersonalTransactionState.initial({
    required PersonalTransactionStateStore store,
  }) = Initial;

  const factory PersonalTransactionState.changeLoaderState({
    required PersonalTransactionStateStore store,
  }) = ChangeLoaderState;

  const factory PersonalTransactionState.onFailure({
    required PersonalTransactionStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      PersonalTransactionState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      PersonalTransactionState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class PersonalTransactionStateStore with _$PersonalTransactionStateStore {
  const factory PersonalTransactionStateStore({
    @Default(false) bool loading,
  }) = _PersonalTransactionStateStore;
}
