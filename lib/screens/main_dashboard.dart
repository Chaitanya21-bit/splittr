import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/screens/popup_screens/add_transaction_popup.dart';
import 'package:splitter/screens/popup_screens/new_group_popup.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:splitter/widgets/group_item.dart';
import 'package:splitter/widgets/navigation_drawer.dart';
import '../dataclass/group.dart';
import '../dataclass/transactions.dart';
import '../widgets/transaction_item.dart';
import 'popup_screens/join_group_popup.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final FirebaseDatabase database = FirebaseManager.database;
  final FirebaseAuth auth = FirebaseManager.auth;
  late Person person;
  Future<void> retrieveDynamicLink() async {
    String? gid;
    Group? group;

    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        if (deepLink.queryParameters.containsKey("id")) {
          gid = deepLink.queryParameters['id'];
          group = await getGroup(gid!);
          await wantToJoin(context, person, group!);
        } else {
          return;
        }
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        if (dynamicLinkData.link.queryParameters.containsKey("id")) {
          gid = dynamicLinkData.link.queryParameters['id'];
          group = await getGroup(gid!);
          if (group == null) {
            return;
          }
          await wantToJoin(context, person, group!);
        } else {
          return;
        }
      }).onError((error) {
        // Handle errors
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Group?> getGroup(String gid) async {
    AuthUtils.showLoadingDialog(context);
    FirebaseDatabase database = FirebaseManager.database;
    final grpSnapshot = await database.ref().child('Group/$gid').get();

    if (!grpSnapshot.exists) {
      Fluttertoast.showToast(msg: "Group Not Found $gid");
      Navigator.pop(context);
      return null;
    }
    print(gid);
    Map<String, dynamic> map =
        Map<String, dynamic>.from(grpSnapshot.value as Map<dynamic, dynamic>);
    Group group = Group.fromJson(map);
    await group.retrieveMembers(List.of(map['members'].cast<String>()));
    Navigator.pop(context);
    return group;
  }

  @override
  void initState() {
    person = Provider.of<Person>(context, listen: false);
    retrieveDynamicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar = AppBar(
      title: Text('Dashboard'),
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_none)),
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
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUserTransaction(context, person);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text(person.name),
          Expanded(
              child: Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    0.3,
                margin: const EdgeInsets.all(10.0),
                width: 400,
                child: Consumer<Person>(
                  builder: (_, data, __) {
                    return ListView.builder(
                        itemCount: data.userGroups.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GroupItem(group: data.userGroups[index]);
                        });
                  },
                ),
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await joinGroup(context, person);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),

                      //minimumSize: Size(100, 40),
                    )),
                icon: const Text("Join Group"),
                label: const Icon(Icons.add_circle),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await newGroup(context, person);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),

                      //minimumSize: Size(100, 40),
                    )),
                icon: const Text("New Group"),
                label: const Icon(Icons.add_circle),
              ),
            ],
          ),
          SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.585,
              child: Consumer<Person>(
                builder: (_, data, __) {
                  List<Transactions> transactionsList =
                      data.userTransactions.reversed.toList();
                  return ListView.builder(
                      itemCount: transactionsList.length,
                      itemBuilder: (context, index) {
                        if (index == transactionsList.length) {
                          return const SizedBox(height: 75.0);
                        }
                        return Column(
                          children: [
                            TransactionItem(transItem: transactionsList[index]),
                          ],
                        );
                      });
                },
              )),
        ],
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
