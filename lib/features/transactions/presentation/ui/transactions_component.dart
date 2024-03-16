import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/transactions/presentation/blocs/transactions_bloc.dart';

class TransactionsComponent extends StatelessWidget {
  const TransactionsComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionsBloc>()..started(),
      child: BlocConsumer<TransactionsBloc, TransactionsState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, TransactionsState state) {}

  Widget _handleWidget(BuildContext context, TransactionsState state) {
    return const Placeholder();
  }
}
