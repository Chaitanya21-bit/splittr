import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/user.dart';
import 'package:splitter/components/dialogs/add_personal_transaction_dialog.dart';
import 'package:splitter/services/firebase_auth_service.dart';
import 'package:splitter/services/group_service.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import 'package:splitter/services/user_service.dart';

import '../components/dialogs/join_group_popup.dart';
import '../components/dialogs/create_group_dialog.dart';
import '../components/cards/group_card.dart';
import '../components/cards/transaction_card.dart';
import '../dataclass/personalTransactions.dart';
import '../size_config.dart';
import 'drawer_screens/profile.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  late User user;



  // Future<Group?> getGroup(String gid) async {
  //   AuthUtils.showLoadingDialog(context);
  //   FirebaseDatabase database = FirebaseManager.database;
  //   final grpSnapshot = await database.ref().child('Group/$gid').get();
  //
  //   if (!grpSnapshot.exists) {
  //     Fluttertoast.showToast(msg: "Group Not Found $gid");
  //     Navigator.pop(context);
  //     return null;
  //   }
  //   print(gid);
  //   Map<String, dynamic> map =
  //       Map<String, dynamic>.from(grpSnapshot.value as Map<dynamic, dynamic>);
  //   Group group = await Group.fromJson(map);
  //   await group.retrieveMembers(List.of(map['members'].cast<String>()));
  //   Navigator.pop(context);
  //   return group;
  // }

  @override
  void initState() {
    user = Provider.of<UserService>(context, listen: false).user;
    // retrieveDynamicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // final dynamic appBar = AppBar(
    //   title: const Text('Dashboard'),
    //   actions: [
    //     IconButton(
    //         onPressed: () {}, icon: const Icon(Icons.notifications_none)),
    //   ],
    //   elevation: 7,
    //   flexibleSpace: Container(
    //     decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //       colors: [Colors.yellow, Colors.orange, Colors.lightBlue],
    //       begin: Alignment.bottomRight,
    //       end: Alignment.topLeft,
    //     )),
    //   ),
    // );

    return Scaffold(
      // appBar: appBar,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () => addPersonalTransactionDialog(context, user),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            backgroundColor: const Color(0xff223146),
            foregroundColor: Colors.white,
            shadowColor: Colors.blueAccent,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )),
        icon: const Text("Add"),
        label: const Icon(
          Icons.add_circle,
        ),
      ),
      body: Column(
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
                  )),
              IconButton(onPressed: () => FirebaseAuthService.signOut(), icon: const Icon(Icons.logout)),
              IconButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }, icon: const Icon(Icons.account_circle_sharp)),
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

          //Button
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.01,
              bottom: SizeConfig.screenHeight * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await createGroupDialog(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      backgroundColor: const Color(0xff223146),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                        //minimumSize: Size(100, 40),
                      )),
                  icon: const Text("Create"),
                  label: const Icon(Icons.add_circle),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await joinGroup(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      backgroundColor: const Color(0xff223146),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                  icon: const Text("Join"),
                  label: const Icon(
                    Icons.add_circle,
                  ),
                ),
              ],
            ),
          ),

          // Groups
          buildGroups(),
          // Transactions
          buildTransactions(),
        ],
      ),
    );
  }

  Widget buildGroups() {
    return Expanded(
      flex: 4,
      child: Consumer<GroupService>(
        builder: (_, groupService, __) {
          if (groupService.groups.isEmpty) {
            return Column(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Welcome to Splittr",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Since you are not in any group, you can select either to join or create a group.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ),
            ]);
          }
          else {
            return ListView.builder(
                itemCount: groupService.groups.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GroupCard(group: groupService.groups[index],index: index,);
                });
          }
        },
      ),
    );
  }

  Widget buildTransactions() {
    return Expanded(
      flex: 8,
      child: Consumer<PersonalTransactionService>(
        builder: (_, data, __) {
          List<PersonalTransaction> transactionsList =
              List<PersonalTransaction>.from(
                  data.personalTransactions.reversed);
          return transactionsList.isEmpty
                 ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      "No Transactions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
              : ListView.builder(
                  itemCount: transactionsList.length + 1,
                  itemBuilder: (context, index) {
                    return index == transactionsList.length
                        ? const SizedBox(height: 75.0)
                        : TransactionCard(transaction: transactionsList[index]);
                  },
                );
        },
      ),
    );
  }
}
