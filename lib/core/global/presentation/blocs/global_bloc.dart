import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/core/user/domain/models/user.dart';

part 'global_bloc.freezed.dart';

part 'global_event.dart';

part 'global_state.dart';

@injectable
final class GlobalBloc extends BaseBloc<GlobalEvent, GlobalState> {
  GlobalBloc()
      : super(
          const GlobalState.initial(
            store: GlobalStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_UserUpdated>(_onUserUpdated);
  }

  void _onStarted(
    _,
    Emitter<GlobalState> emit,
  ) {}

  void _onUserUpdated(
    _UserUpdated event,
    Emitter<GlobalState> emit,
  ) {
    emit(
      GlobalState.updatedUser(
        store: state.store.copyWith(
          user: event.user,
        ),
      ),
    );
  }

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const GlobalEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;

  void userUpdated(User user) {
    add(GlobalEvent.userUpdated(user: user));
  }
}
