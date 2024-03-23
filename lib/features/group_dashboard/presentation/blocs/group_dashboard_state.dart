part of 'group_dashboard_bloc.dart';

@freezed
sealed class GroupDashboardState extends BaseState with _$GroupDashboardState {
  const GroupDashboardState._();

  const factory GroupDashboardState.initial({
    required GroupDashboardStateStore store,
  }) = Initial;

  const factory GroupDashboardState.changeLoaderState({
    required GroupDashboardStateStore store,
  }) = ChangeLoaderState;

  const factory GroupDashboardState.onFailure({
    required GroupDashboardStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      GroupDashboardState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      GroupDashboardState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class GroupDashboardStateStore with _$GroupDashboardStateStore {
  const factory GroupDashboardStateStore({
    @Default(false) bool loading,
  }) = _GroupDashboardStateStore;
}
