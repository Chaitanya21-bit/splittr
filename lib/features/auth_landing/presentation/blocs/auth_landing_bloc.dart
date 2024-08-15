import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'auth_landing_bloc.freezed.dart';

part 'auth_landing_event.dart';

part 'auth_landing_state.dart';

@injectable
final class AuthLandingBloc extends BaseBloc<AuthLandingEvent, AuthLandingState> {
  AuthLandingBloc()
      : super(
          const AuthLandingState.initial(
            store: AuthLandingStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<AuthLandingState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const AuthLandingEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
