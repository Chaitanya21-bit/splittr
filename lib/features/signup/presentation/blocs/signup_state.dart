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

  const factory SignupState.onFailure({
    required SignupStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      SignupState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      SignupState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class SignupStateStore with _$SignupStateStore {
  const factory SignupStateStore({
    @Default(false) bool loading,
  }) = _SignupStateStore;
}
