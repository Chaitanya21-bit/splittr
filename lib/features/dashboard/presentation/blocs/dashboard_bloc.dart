import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'dashboard_bloc.freezed.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

@injectable
final class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  DashboardBloc()
    : super(const DashboardState.initial(store: DashboardStateStore()));

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<DashboardState> emit) {}

  @override
  void started({Map<String, dynamic>? args}) {
    add(const DashboardEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
