import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'base_event.dart';

part 'base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<Event, State> {
  BaseBloc(super.initialState) {
    handleEvents();
  }

  bool get isLoading;

  void handleEvents();

  void started({Map<String, dynamic>? args});

  void changeLoaderState({
    required Emitter<BaseState> emit,
    required bool loading,
  }) {
    emit(state.getLoaderState(loading: loading));
  }

  void handleFailure({
    required Emitter<BaseState> emit,
    required Failure failure,
  }) {
    emit(state.getFailureState(failure));
  }
}
