import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base_page/base_page.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/splash/presentation/blocs/splash_bloc.dart';

part 'splash_form.dart';

class SplashPage extends BasePage<SplashBloc> {
  const SplashPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, SplashState state) {
    return switch (state) {
      UserAuthorized _ => _navigateToDashboardPage(context),
      _ => _navigateToLoginPage(context),
    };
  }

  Widget _handleWidget(BuildContext context, SplashState state) {
    return const _SplashForm();
  }

  @override
  SplashBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<SplashBloc>()..started();
  }

  void _navigateToDashboardPage(BuildContext context) {
    RouteHandler.pushReplacement(context, RouteId.dashboard);
  }

  void _navigateToLoginPage(BuildContext context) {
    RouteHandler.pushReplacement(context, RouteId.login);
  }
}
