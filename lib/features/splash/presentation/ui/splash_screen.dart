import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_screen/base_screen.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/splash/presentation/blocs/splash_bloc.dart';

class SplashScreen extends BaseScreen<SplashBloc> {
  const SplashScreen({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (_, __) => TextButton(
            onPressed: () async {
              RouteHandler.push(
                context,
                RouteId.dashboard,
                args: {
                  'he;;p': 'cmjsc',
                },
              );
            },
            child: const Text('Splash'),
          ),
        ),
      ),
    );
  }

  @override
  SplashBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<SplashBloc>()..started();
  }
}
