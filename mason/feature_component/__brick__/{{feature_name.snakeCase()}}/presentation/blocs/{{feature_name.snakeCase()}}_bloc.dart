import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part '{{feature_name.snakeCase()}}_bloc.freezed.dart';

part '{{feature_name.snakeCase()}}_event.dart';

part '{{feature_name.snakeCase()}}_state.dart';

@injectable
final class {{feature_name.pascalCase()}}Bloc extends BaseBloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  {{feature_name.pascalCase()}}Bloc()
      : super(
          const {{feature_name.pascalCase()}}State.initial(
            store: {{feature_name.pascalCase()}}StateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<{{feature_name.pascalCase()}}State> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const {{feature_name.pascalCase()}}Event.started());
  }

  @override
  bool get isLoading => state.store.loading;
}
