import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/splash/presentation/blocs/splash_bloc.dart';

class SplashComponent extends StatelessWidget {
  const SplashComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashBloc>()..started(),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, SplashState state) {}

  Widget _handleWidget(BuildContext context, SplashState state) {
    return const Placeholder();
  }
}
