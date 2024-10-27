import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/core/designs/button/app_transparent_button.dart';
import 'package:splittr/core/designs/color/app_colors.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/features/signup/presentation/blocs/signup_bloc.dart';

part 'signup_form.dart';

class SignupPage extends BasePage<SignupBloc> {
  const SignupPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, SignupState state) {}

  Widget _handleWidget(BuildContext context, SignupState state) {
    return const _SignupForm();
  }
}
