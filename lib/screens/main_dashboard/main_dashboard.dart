import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/add_transaction_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/create_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/buttons/join_group_button.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/groups_widget.dart';
import 'package:splitter/screens/main_dashboard/components/widgets/personal_transactions_widget.dart';

import '../../components/background.dart';
import '../../components/navigation_drawer.dart';
import '../../size_config.dart';
import '../../utils/get_provider.dart';
import '../drawer_screens/profile.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getProvider<UserProvider>(context).user;
    final authProvider = getProvider<FirebaseAuthProvider>(context);
    SizeConfig().init(context);
    final dynamic appBar = AppBar(
      title: const Text('Dashboard'),
      actions: [
        IconButton(
          onPressed: () => {authProvider.signOut()},
          icon: const Icon(Icons.logout),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.account_circle_sharp)),
      ],
      elevation: 7,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.yellow, Colors.orange, Colors.lightBlue],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )),
      ),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: const AddPersonalTransactionButton(),
      drawer: const NavigationDrawerWidget(),
      body: BackgroundStack(
        builder: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.05,
                    // bottom: SizeConfig.screenHeight * 0.05,
                  ),
                  child: Image.asset(
                    "assets/SplittrLogo.png",
                    width: SizeConfig.screenHeight * 0.2,
                  ),
                ),
                // ElevatedButton(onPressed: () {ProfileScreen();}, child: Text("P"))
              ],
            ),
            //Name
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.015, right: 0, left: 0),
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            buildGroupButtons(),
            buildGroups(),
            buildTransactions(),
          ],
        ),
      ),
    );
  }

  Widget buildGroupButtons() {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.01,
        bottom: SizeConfig.screenHeight * 0.01,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CreateGroupButton(),
          JoinGroupButton(),
        ],
      ),
    );
  }

  Widget buildGroups() {
    return const Expanded(
      flex: 2,
      child: GroupsWidget(),
    );
    // return GroupsWidget();
  }

  Widget buildTransactions() {
    return const Expanded(
      flex: 4,
      child: PersonalTransactionsWidget(),
    );
  }
}
