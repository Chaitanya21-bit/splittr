part of 'profile_bloc.dart';

@freezed
sealed class ProfileState extends BaseState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState.initial({required ProfileStateStore store}) =
      Initial;

  const factory ProfileState.changeLoaderState({
    required ProfileStateStore store,
  }) = ChangeLoaderState;

  const factory ProfileState.onFailure({
    required ProfileStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(Failure failure) => ProfileState.onFailure(
    store: store.copyWith(loading: false),
    failure: failure,
  );

  @override
  BaseState getLoaderState({required bool loading}) =>
      ProfileState.changeLoaderState(store: store.copyWith(loading: loading));
}

@freezed
class ProfileStateStore with _$ProfileStateStore {
  const ProfileStateStore({this.loading = false});

  @override
  final bool loading;
}
