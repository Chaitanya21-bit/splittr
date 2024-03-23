part of 'groups_bloc.dart';

@freezed
sealed class GroupsState extends BaseState with _$GroupsState {
  const GroupsState._();

  const factory GroupsState.initial({
    required GroupsStateStore store,
  }) = Initial;

  const factory GroupsState.changeLoaderState({
    required GroupsStateStore store,
  }) = ChangeLoaderState;

  const factory GroupsState.onFailure({
    required GroupsStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      GroupsState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      GroupsState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class GroupsStateStore with _$GroupsStateStore {
  const factory GroupsStateStore({
    @Default(false) bool loading,
  }) = _GroupsStateStore;
}
