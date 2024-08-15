part of 'auth_landing_bloc.dart';

@freezed
sealed class AuthLandingState extends BaseState with _$AuthLandingState {
  const AuthLandingState._();

  const factory AuthLandingState.initial({
    required AuthLandingStateStore store,
  }) = Initial;

  const factory AuthLandingState.changeLoaderState({
    required AuthLandingStateStore store,
  }) = ChangeLoaderState;

  const factory AuthLandingState.onFailure({
    required AuthLandingStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      AuthLandingState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      AuthLandingState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class AuthLandingStateStore with _$AuthLandingStateStore {
  const factory AuthLandingStateStore({
    @Default(false) bool loading,
  }) = _AuthLandingStateStore;
}
