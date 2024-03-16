import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_screen/base_screen.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/dashboard/presentation/blocs/dashboard_bloc.dart';

class DashboardScreen extends BaseScreen<DashboardBloc> {
  const DashboardScreen({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) => TextButton(
            onPressed: () {
              RouteHandler.push(
                context,
                RouteId.dashboard,
                args: {
                  'hy': 'bsahc ${Random().nextInt(100)}',
                },
              );
            },
            child: const Text('Dashboard Screen'),
          ),
        ),
      ),
    );
  }

  @override
  DashboardBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<DashboardBloc>()..started(args: args);
  }
}
