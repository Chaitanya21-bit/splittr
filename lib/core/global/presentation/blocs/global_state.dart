part of 'global_bloc.dart';

@freezed
sealed class GlobalState extends BaseState
    with _$GlobalState {
  const GlobalState._();

  const factory GlobalState.initial({
    required GlobalStateStore store,
  }) = Initial;

  const factory GlobalState.updatedUser({
    required GlobalStateStore store,
  }) = UpdatedUser;

  const factory GlobalState.changeLoaderState({
    required GlobalStateStore store,
  }) = ChangeLoaderState;

  const factory GlobalState.onFailure({
    required GlobalStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      GlobalState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      GlobalState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class GlobalStateStore with _$GlobalStateStore {
  const factory GlobalStateStore({
    User? user,
    @Default(false) bool loading,
  }) = _GlobalStateStore;
}
