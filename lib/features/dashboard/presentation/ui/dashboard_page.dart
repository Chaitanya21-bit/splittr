import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_page/base_page.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/dashboard/presentation/blocs/dashboard_bloc.dart';

part 'dashboard_form.dart';

class DashboardPage extends BasePage<DashboardBloc> {
  const DashboardPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, DashboardState state) {}

  Widget _handleWidget(BuildContext context, DashboardState state) {
    return const _DashboardForm();
  }

  @override
  DashboardBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<DashboardBloc>()..started();
  }
}
