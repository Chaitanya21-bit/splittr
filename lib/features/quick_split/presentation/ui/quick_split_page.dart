import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/base/base_page/base_page.dart';
import 'package:splittr/core/designs/color/app_colors.dart';
import 'package:splittr/core/designs/components/background_wrapper.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/features/quick_split/presentation/blocs/quick_split_bloc.dart';
import 'package:splittr/features/quick_split/presentation/ui/components/quick_split_input_card.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';
import 'package:splittr/utils/snack_bar/snack_bar.dart';

part 'quick_split_form.dart';

class QuickSplitPage extends BasePage<QuickSplitBloc> {
  const QuickSplitPage({
    super.key,
    required super.args,
  });

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueBgColor,
        centerTitle: true,
        title: const Text(
          'Quick Split',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: BlocConsumer<QuickSplitBloc, QuickSplitState>(
        listener: _handleState,
        builder: _handleWidget,
      ),
    );
  }

  void _handleState(BuildContext context, QuickSplitState state) {
    return switch (state) {
      InvalidAmount(:final invalidAmount) => invalidAmount.isEmpty
          ? showSnackBar(context, 'Empty amount are not allowed')
          : showSnackBar(context, '$invalidAmount is an invalid amount'),
      EmptyName() => showSnackBar(context, 'Empty names are not allowed'),
      QuickSettle _ => _navigateToQuickSettlePage(
          context: context,
          state: state,
        ),
      _ => () {},
    };
  }

  void _navigateToQuickSettlePage({
    required BuildContext context,
    required QuickSplitState state,
  }) {
    RouteHandler.push(
      context,
      RouteId.quickSettle,
      args: {
        StringConstants.peopleRecords:
            state.store.peopleRecords.map((peopleRecord) {
          return (
            name: peopleRecord.name,
            amount: double.tryParse(peopleRecord.amount) ?? 0
          );
        }).toList(),
      },
    );
  }

  Widget _handleWidget(BuildContext context, QuickSplitState state) {
    return const _QuickSplitForm();
  }
}
