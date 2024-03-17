import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_page/base_page.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/group_dashboard/presentation/blocs/group_dashboard_bloc.dart';

part 'group_dashboard_form.dart';

class GroupDashboardPage extends BasePage<GroupDashboardBloc> {
  const GroupDashboardPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GroupDashboardBloc, GroupDashboardState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, GroupDashboardState state) {}

  Widget _handleWidget(BuildContext context, GroupDashboardState state) {
    return const _GroupDashboardForm();
  }

  @override
  GroupDashboardBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<GroupDashboardBloc>()..started();
  }
}
