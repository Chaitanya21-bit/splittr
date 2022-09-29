import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../auth_screens/login_screen.dart';

class QuickSettle extends StatefulWidget {
  const QuickSettle({Key? key}) : super(key: key);

  @override
  State<QuickSettle> createState() => _QuickSettleState();
}

class _QuickSettleState extends State<QuickSettle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quick Settle'),
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
    ));
  }
}
