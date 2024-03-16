import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/{{feature_name.snakeCase()}}/presentation/blocs/{{feature_name.snakeCase()}}_bloc.dart';

class {{feature_name.pascalCase()}}Component extends StatelessWidget {
  const {{feature_name.pascalCase()}}Component({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<{{feature_name.pascalCase()}}Bloc>()..started(),
      child: BlocConsumer<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, {{feature_name.pascalCase()}}State state) {}

  Widget _handleWidget(BuildContext context, {{feature_name.pascalCase()}}State state) {
    return const Placeholder();
  }
}
