part of 'base_bloc.dart';

abstract class BaseState {
  const BaseState();

  BaseState getLoaderState({
    required bool loading,
  });

  BaseState getFailureState(
    Failure failure,
  );
}
