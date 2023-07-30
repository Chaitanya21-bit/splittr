import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';

import '../constants/routes.dart';
import '../utils/get_provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: SafeArea(
        child: Material(
          child: ListView(
            padding: padding,
            children: [
              buildMenuItem(
                drawerText: 'Profile',
                drawerIcon: Icons.person,
                onClicked: () => Navigator.pushNamed(context, Routes.profile),
              ),
              const SizedBox(height: 20),
              buildMenuItem(
                drawerText: 'Quick Settle',
                drawerIcon: Icons.handshake_outlined,
                onClicked: () =>
                    Navigator.pushNamed(context, Routes.quickSettle),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black),
              const SizedBox(height: 20),
              buildMenuItem(
                drawerText: 'LogOut',
                drawerIcon: Icons.logout,
                onClicked: () =>
                    getProvider<FirebaseAuthProvider>(context).signOut(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String drawerText,
    required IconData drawerIcon,
    required VoidCallback onClicked,
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
}
