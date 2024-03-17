part of 'dashboard_bloc.dart';

@freezed
sealed class DashboardState extends BaseState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState.initial({
    required DashboardStateStore store,
  }) = Initial;

  const factory DashboardState.changeLoaderState({
    required DashboardStateStore store,
  }) = ChangeLoaderState;

  const factory DashboardState.onException({
    required DashboardStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      DashboardState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      DashboardState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class DashboardStateStore with _$DashboardStateStore {
  const factory DashboardStateStore({
    @Default(false) bool loading,
  }) = _DashboardStateStore;
}
