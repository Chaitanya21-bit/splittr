part of '{{feature_name.snakeCase()}}_bloc.dart';

@freezed
sealed class {{feature_name.pascalCase()}}State extends BaseState with _${{feature_name.pascalCase()}}State {
  const {{feature_name.pascalCase()}}State._();

  const factory {{feature_name.pascalCase()}}State.initial({
    required {{feature_name.pascalCase()}}StateStore store,
  }) = Initial;

  const factory {{feature_name.pascalCase()}}State.changeLoaderState({
    required {{feature_name.pascalCase()}}StateStore store,
  }) = ChangeLoaderState;

  const factory {{feature_name.pascalCase()}}State.onFailure({
    required {{feature_name.pascalCase()}}StateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      {{feature_name.pascalCase()}}State.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      {{feature_name.pascalCase()}}State.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class {{feature_name.pascalCase()}}StateStore with _${{feature_name.pascalCase()}}StateStore {
  const factory {{feature_name.pascalCase()}}StateStore({
    @Default(false) bool loading,
  }) = _{{feature_name.pascalCase()}}StateStore;
}
