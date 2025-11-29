import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'signup_bloc.freezed.dart';

part 'signup_event.dart';

part 'signup_state.dart';

@injectable
final class SignupBloc extends BaseBloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState.initial(store: SignupStateStore()));

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<SignupState> emit) {}

  @override
  void started({Map<String, dynamic>? args}) {
    add(const SignupEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
