import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'group_dashboard_bloc.freezed.dart';

part 'group_dashboard_event.dart';

part 'group_dashboard_state.dart';

@injectable
final class GroupDashboardBloc
    extends BaseBloc<GroupDashboardEvent, GroupDashboardState> {
  GroupDashboardBloc()
      : super(
          const GroupDashboardState.initial(
            store: GroupDashboardStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<GroupDashboardState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const GroupDashboardEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
