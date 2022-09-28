
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
                drawerText: 'Profile',
                drawerIcon: Icons.person,
                onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(color: Colors.black),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              drawerText: 'LogOut',
              drawerIcon: Icons.logout,
              onClicked: () => selectedItem(context, 1),
            ),

          ],
        ),

      ),
    );
  }

 Widget buildMenuItem({
    required String drawerText,
    required IconData drawerIcon,
    VoidCallback? onClicked,
  }) {
      const color = Colors.black;
      return ListTile(
        leading: Icon(drawerIcon, color: color,),
        title: Text(drawerText),
        onTap: onClicked,
      );

  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch(i){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GroupDashboard()));
        break;
      case 1:
        FirebaseManager.auth.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        break;
    }

  }
}
