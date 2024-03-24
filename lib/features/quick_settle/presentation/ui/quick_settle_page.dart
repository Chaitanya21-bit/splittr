import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/core/base/base_page//base_page.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/quick_settle/presentation/blocs/quick_settle_bloc.dart';

part 'quick_settle_form.dart';

class QuickSettlePage extends BasePage<QuickSettleBloc> {
  const QuickSettlePage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuickSettleBloc, QuickSettleState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, QuickSettleState state) {}

  Widget _handleWidget(BuildContext context, QuickSettleState state) {
    return const _QuickSettleForm();
  }

  @override
  QuickSettleBloc getImplementedBloc({
    required BuildContext context,
    Map<String, dynamic>? args,
  }) {
    return getIt<QuickSettleBloc>()..started();
  }
}
