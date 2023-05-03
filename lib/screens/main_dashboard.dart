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
import 'package:splitter/services/personal_transaction_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import '../components/transaction_card.dart';
import '../dataclass/group.dart';
import '../dataclass/transactions.dart';
import '../size_config.dart';
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
    Group group = await Group.fromJson(map);
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
    SizeConfig().init(context);
    final dynamic appBar = AppBar(
      title: const Text('Dashboard'),
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
      // appBar: appBar,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          addPersonalTransactionDialog(context, person);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            backgroundColor: Color(0xff223146),
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
              IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: Icon(Icons.logout))
            ],
          ),
          //Name
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.015,
                right: 0,
                left: 0),
            child: Text(
              person.name,
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
                    await newGroup(context, person);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      backgroundColor: Color(0xff223146),
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
                    await joinGroup(context, person);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      backgroundColor: Color(0xff223146),
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

  Widget buildTransactions() {
    return Expanded(
      flex: 8,
      child: Consumer<PersonalTransactionService>(
        builder: (_, data, __) {
          List<PersonalTransaction> transactionsList =
              List<PersonalTransaction>.from(data.personalTransactions.reversed);
          return transactionsList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Currently no transactions are added",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: transactionsList.length + 1,
                  itemBuilder: (context, index) {
                    return index == transactionsList.length
                        ? const SizedBox(height: 75.0)
                        : TransactionCard(
                            transaction: transactionsList[index]);
                  });
        },
      ),
    );
  }

  Widget buildGroups() {
    return Expanded(
      flex: 3,
      child: Consumer<Person>(
        builder: (_, data, __) {
          if (data.groups.isEmpty) {
            return Column(children: <Widget>[
              Expanded(
                child : Padding(
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
                child : Padding(
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
          } else {
            return ListView.builder(
                itemCount: data.groups.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox();
                  // return GroupItem(group: data.userGroups[index]);
                });
          }
        },
      ),
    );
  }
}
