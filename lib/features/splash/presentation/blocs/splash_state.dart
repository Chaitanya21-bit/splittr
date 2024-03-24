part of 'splash_bloc.dart';

@freezed
sealed class SplashState extends BaseState with _$SplashState {
  const SplashState._();

  const factory SplashState.initial({
    required SplashStateStore store,
  }) = Initial;

  const factory SplashState.showedSplash({
    required SplashStateStore store,
  }) = ShowedSplash;

  const factory SplashState.userAuthorized({
    required SplashStateStore store,
  }) = UserAuthorized;

  const factory SplashState.userUnauthorized({
    required SplashStateStore store,
  }) = UserUnauthorized;

  const factory SplashState.userNotFound({
    required SplashStateStore store,
  }) = UserNotFound;

  const factory SplashState.changeLoaderState({
    required SplashStateStore store,
  }) = ChangeLoaderState;

  const factory SplashState.onFailure({
    required SplashStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      SplashState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      SplashState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class SplashStateStore with _$SplashStateStore {
  const factory SplashStateStore({
    @Default(false) bool splashShown,
    @Default(false) bool authChecked,
    @Default(false) bool isAuthorized,
    @Default(false) bool loading,
  }) = _SplashStateStore;
}
