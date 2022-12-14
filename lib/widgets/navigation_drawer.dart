import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/screens/drawer_screens/profile.dart';
import 'package:splitter/screens/drawer_screens/quick_settle.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';

import '../auth/firebase_manager.dart';
import '../dataclass/person.dart';
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
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            buildMenuItem(
              drawerText: 'Profile',
              drawerIcon: Icons.person,
              onClicked: () => Navigator.pushNamed(context, '/profile',
                  arguments: Provider.of<Person>(context, listen: false)),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              drawerText: 'Quick Settle',
              drawerIcon: Icons.handshake_outlined,
              onClicked: () => selectedItem(context, 2),
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
      leading: Icon(
        drawerIcon,
        color: color,
      ),
      title: Text(drawerText),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 1:
        FirebaseManager.auth.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const QuickSettle()));
        break;
    }
  }
}
