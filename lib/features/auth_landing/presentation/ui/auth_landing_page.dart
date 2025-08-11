import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:splittr/constants/animations/animation_keys.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/core/designs/button/app_fill_button.dart';
import 'package:splittr/core/designs/color/app_colors.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/features/auth_landing/presentation/blocs/auth_landing_bloc.dart';

part 'auth_landing_form.dart';

class AuthLandingPage extends BasePage<AuthLandingBloc> {
  const AuthLandingPage({super.key, required super.args});

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.denimColor,
      body: BlocConsumer<AuthLandingBloc, AuthLandingState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, AuthLandingState state) {}

  Widget _handleWidget(BuildContext context, AuthLandingState state) {
    return const _AuthLandingForm();
  }
}
