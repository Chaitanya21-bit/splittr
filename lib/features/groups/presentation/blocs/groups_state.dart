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

  const factory GroupsState.onException({
    required GroupsStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      GroupsState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      GroupsState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class GroupsStateStore with _$GroupsStateStore {
  const factory GroupsStateStore({
    @Default(false) bool loading,
  }) = _GroupsStateStore;
}
