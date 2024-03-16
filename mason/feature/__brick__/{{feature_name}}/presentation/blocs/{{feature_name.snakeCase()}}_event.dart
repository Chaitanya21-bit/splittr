part of '{{feature_name.snakeCase()}}_bloc.dart';

@freezed
class {{feature_name.pascalCase()}}Event extends BaseEvent with _${{feature_name.pascalCase()}}Event {
  const factory {{feature_name.pascalCase()}}Event.started() = _Started;
}
