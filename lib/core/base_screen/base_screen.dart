import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_bloc/base_bloc.dart';

abstract class BaseScreen<B extends BaseBloc> extends StatelessWidget {
  final Map<String, dynamic>? args;

  const BaseScreen({
    super.key,
    required this.args,
  });

  Widget buildScreen(BuildContext context);

  B getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (_) => getImplementedBloc(
        context: context,
        args: args,
      ),
      child: buildScreen(context),
    );
  }
}
