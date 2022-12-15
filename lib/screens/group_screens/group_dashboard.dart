import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/dataclass/person.dart';
import '../main_dashboard.dart';
import '../../dataclass/group.dart';
import '../../dataclass/group.dart';
import '../popup_screens/add_money_popup.dart';
import 'group_details_dropdown.dart';

class GroupDashboard extends StatelessWidget {

  final Group group;

  GroupDashboard({
    Key? key,
    required this.group
  }) : super(key: key);
  late Group G;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseManager.auth.signOut();
                Navigator.of(context).pushNamed(
                    '/login'
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openDialogue(context);
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1,
              right: 10,
              left: 50,
              bottom: 5,
            ),
          ),
          Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3,
              width: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
              child: Image.asset("assets/SplittrLogo.png")
          ),
          Container(
              margin: const EdgeInsets.all(25),
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                  right: 30,
                  left: 30
              ),
              child: Column(
                children: [
                  // Row(children: [Expanded(child: GroupDetailsDropdown(group: group,))]),
                  // Isko uncomment karne se error aara
                  Text(group.gid),
                  Text(group.members.toString()),
                  Text(group.groupName),
                ],
              )
          )
        ],
      ),
    );
  }
}