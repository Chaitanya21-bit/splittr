part of 'base_bloc.dart';

abstract class BaseState {
  const BaseState();

  BaseState getLoaderState({
    required bool loading,
  });

  BaseState getExceptionState(
    Exception exception,
  );
}
