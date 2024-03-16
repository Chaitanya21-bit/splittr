import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base_screen/base_screen.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/quick_split/presentation/blocs/quick_split_bloc.dart';

part 'quick_split_form.dart';

class QuickSplitPage extends BaseScreen<QuickSplitBloc> {
  const QuickSplitPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuickSplitBloc, QuickSplitState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, QuickSplitState state) {}

  Widget _handleWidget(BuildContext context, QuickSplitState state) {
    return const _QuickSplitForm();
  }

  @override
  QuickSplitBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<QuickSplitBloc>()..started();
  }
}
