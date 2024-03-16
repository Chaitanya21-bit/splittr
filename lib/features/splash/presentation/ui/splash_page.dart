import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_screen/base_screen.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/splash/presentation/blocs/splash_bloc.dart';

part 'splash_form.dart';

class SplashPage extends BaseScreen<SplashBloc> {
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

  void _handleState(BuildContext context, SplashState state) {}

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
}
