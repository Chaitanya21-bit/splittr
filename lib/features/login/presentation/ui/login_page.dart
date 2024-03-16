import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_screen/base_screen.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/login/presentation/blocs/login_bloc.dart';

part 'login_form.dart';

class LoginPage extends BaseScreen<LoginBloc> {
  const LoginPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, LoginState state) {}

  Widget _handleWidget(BuildContext context, LoginState state) {
    return const _LoginForm();
  }

  @override
  LoginBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<LoginBloc>()..started();
  }
}
