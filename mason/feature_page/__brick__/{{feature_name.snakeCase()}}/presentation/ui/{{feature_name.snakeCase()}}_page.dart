import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/features/{{feature_name.snakeCase()}}/presentation/blocs/{{feature_name.snakeCase()}}_bloc.dart';

part '{{feature_name.snakeCase()}}_form.dart';

class {{feature_name.pascalCase()}}Page extends BasePage<{{feature_name.pascalCase()}}Bloc> {
  const {{feature_name.pascalCase()}}Page({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, {{feature_name.pascalCase()}}State state) {}

  Widget _handleWidget(BuildContext context, {{feature_name.pascalCase()}}State state) {
    return const _{{feature_name.pascalCase()}}Form();
  }
}
