
import 'package:flutter/material.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';

import '../auth/firebase_manager.dart';
import '../screens/auth_screens/login_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Material(

        child: ListView(
          padding: padding,
          children:  <Widget>[
            const SizedBox(
              height: 40,
            ),
            buildMenuItem(
                drawer_text: 'Profile',
                drawer_icon: Icons.person,
                onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(color: Colors.black),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              drawer_text: 'LogOut',
              drawer_icon: Icons.logout,
              onClicked: () => selectedItem(context, 1),
            ),

          ],
        ),

      ),
    );
  }

 Widget buildMenuItem({
    required String drawer_text,
    required IconData drawer_icon,
    VoidCallback? onClicked,
  }) {
      const color = Colors.black;
      return ListTile(
        leading: Icon(drawer_icon, color: color,),
        title: Text(drawer_text),
        onTap: onClicked,
      );

  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch(i){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const GroupDashboard()));
        break;
      case 1:
        FirebaseManager.auth.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        break;
    }

  }
}
