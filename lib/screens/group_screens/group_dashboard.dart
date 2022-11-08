import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/dataclass/person.dart';
import '../popup_screens/add_money_popup.dart';

class GroupDashboard extends StatelessWidget {

  final String data;
  GroupDashboard({
    Key? key,
    required this.data
  }) : super(key: key);


  final FirebaseAuth _auth = FirebaseAuth.instance;
  // late Person P;


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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
      body: Text(data),
    );
  }
}
