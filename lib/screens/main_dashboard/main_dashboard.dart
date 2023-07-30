import 'package:flutter/material.dart';
import 'package:splitter/constants/colors.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/add_transaction_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/create_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/join_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/app_bar.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/groups_widget.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/header.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/personal_transactions_widget.dart';

import '../../components/background.dart';
import '../../components/navigation_drawer.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainDashboardAppBar(),
      backgroundColor: AppColors.creamBG,
      resizeToAvoidBottomInset: false,
      floatingActionButton: AddPersonalTransactionButton(),
      drawer: NavigationDrawerWidget(),
      body: BackgroundStack(
        child: Column(
          children: [
            Header(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CreateGroupButton(),
                  JoinGroupButton(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: GroupsWidget(),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: PersonalTransactionsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
