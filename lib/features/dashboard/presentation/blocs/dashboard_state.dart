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

  const factory DashboardState.onFailure({
    required DashboardStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      DashboardState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
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
