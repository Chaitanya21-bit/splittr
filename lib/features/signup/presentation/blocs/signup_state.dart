part of 'signup_bloc.dart';

@freezed
sealed class SignupState extends BaseState with _$SignupState {
  const SignupState._();

  const factory SignupState.initial({
    required SignupStateStore store,
  }) = Initial;

  const factory SignupState.changeLoaderState({
    required SignupStateStore store,
  }) = ChangeLoaderState;

  const factory SignupState.onException({
    required SignupStateStore store,
    required Exception exception,
  }) = OnException;

  @override
  BaseState getExceptionState(
    Exception exception,
  ) =>
      SignupState.onException(
        store: store.copyWith(
          loading: false,
        ),
        exception: exception,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      SignupState.changeLoaderState(
        store: store.copyWith(
          loading: false,
        ),
      );
}

@freezed
class SignupStateStore with _$SignupStateStore {
  const factory SignupStateStore({
    @Default(false) bool loading,
  }) = _SignupStateStore;
}
