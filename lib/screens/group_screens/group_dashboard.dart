import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/dataclass/person.dart';
import '../main_dashboard.dart';
import '../../dataclass/group.dart';
import '../../dataclass/group.dart';
import '../popup_screens/add_money_popup.dart';

class GroupDashboard extends StatelessWidget {

  final Group group;
  late List<dynamic> user_data = [];
  GroupDashboard({
    Key? key,
    required this.group
  }) : super(key: key);
  late Group G;
  // getGroup(BuildContext context) async{
  //   final snapshot_group = await database.ref('Group/$data').get();
  //   Map<String, dynamic> map = Map<String, dynamic>.from(snapshot_group.value as Map<dynamic, dynamic>);
  // final Group group;
  // GroupDashboard({Key? key, required this.group}) : super(key: key);
  //
  //   G=Group.fromJson(map);
  //   List<dynamic> user_data = [];
  //   //All Groups in DB
  //   user_data = map.values.toList();
  //   print(user_data);
  //   print(G.groupName);
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // late Person P;

  @override
  Widget build(BuildContext context) {

    // getGroup(context);

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
                    // MaterialPageRoute(builder: (context) => LoginScreen()));
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
              top: MediaQuery.of(context).size.height * 0.1,
              right: 10,
              left: 50,
              bottom: 5,
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              left: MediaQuery.of(context).size.width*0.3,
              width:MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/SplittrLogo.png")
          ),
          Container(
              margin: const EdgeInsets.all(25),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 30,
                left: 30
              ),
              child: Column(
                children: [
                  // ListView.builder(
                  //   itemCount: user_data.length, //user data toh empty hai bc
                  //   itemBuilder: (context, index) {
                  //     return Card(
                  //       child: Text(user_data[index].toString()),
                  //     );
                  //   }
                  // ),
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

