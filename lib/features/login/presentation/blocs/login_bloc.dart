import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
final class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(
          const LoginState.initial(
            store: LoginStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<LoginState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const LoginEvent.started());
  }
}
