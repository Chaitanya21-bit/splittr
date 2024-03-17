part of 'splash_bloc.dart';

@freezed
sealed class SplashState extends BaseState with _$SplashState {
  const SplashState._();

  const factory SplashState.initial({
    required SplashStateStore store,
  }) = Initial;

  const factory SplashState.userAuthorized({
    required SplashStateStore store,
  }) = UserAuthorized;

  const factory SplashState.userUnauthorized({
    required SplashStateStore store,
  }) = UserUnauthorized;

  const factory SplashState.changeLoaderState({
    required SplashStateStore store,
  }) = ChangeLoaderState;

  const factory SplashState.onException({
    required SplashStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      SplashState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      SplashState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class SplashStateStore with _$SplashStateStore {
  const factory SplashStateStore({
    @Default(false) bool loading,
  }) = _SplashStateStore;
}
