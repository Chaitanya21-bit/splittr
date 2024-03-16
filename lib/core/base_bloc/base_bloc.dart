import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_event.dart';

part 'base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<Event, State> {
  BaseBloc(super.initialState) {
    handleEvents();
  }

  void handleEvents();

  void started({
    Map<String, dynamic>? args,
  });

  void changeLoaderState({
    required Emitter<BaseState> emit,
    required bool loading,
  }) {
    emit(
      state.getLoaderState(
        loading: loading,
      ),
    );
  }

  void handleException({
    required Emitter<BaseState> emit,
    required Exception exception,
  }) {
    emit(
      state.getExceptionState(
        exception,
      ),
    );
  }
}
