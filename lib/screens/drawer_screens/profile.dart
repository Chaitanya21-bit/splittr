import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../auth_screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
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
