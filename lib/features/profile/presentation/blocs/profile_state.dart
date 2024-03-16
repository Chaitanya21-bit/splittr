part of 'profile_bloc.dart';

@freezed
sealed class ProfileState extends BaseState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState.initial({
    required ProfileStateStore store,
  }) = Initial;

  const factory ProfileState.changeLoaderState({
    required ProfileStateStore store,
  }) = ChangeLoaderState;

  const factory ProfileState.onException({
    required ProfileStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      ProfileState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      ProfileState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class ProfileStateStore with _$ProfileStateStore {
  const factory ProfileStateStore({
    @Default(false) bool loading,
  }) = _ProfileStateStore;
}
