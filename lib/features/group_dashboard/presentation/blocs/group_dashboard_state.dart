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

  const factory GroupDashboardState.onException({
    required GroupDashboardStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      GroupDashboardState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      GroupDashboardState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class GroupDashboardStateStore with _$GroupDashboardStateStore {
  const factory GroupDashboardStateStore({
    @Default(false) bool loading,
  }) = _GroupDashboardStateStore;
}
