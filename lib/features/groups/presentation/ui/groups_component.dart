import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/groups/presentation/blocs/groups_bloc.dart';

class GroupsComponent extends StatelessWidget {
  const GroupsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GroupsBloc>()..started(),
      child: BlocConsumer<GroupsBloc, GroupsState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, GroupsState state) {}

  Widget _handleWidget(BuildContext context, GroupsState state) {
    return const Placeholder();
  }
}
