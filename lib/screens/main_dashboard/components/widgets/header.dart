import 'package:flutter/material.dart';

import '../../../../providers/user_provider.dart';
import '../../../../utils/get_provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = getProvider<UserProvider>(context).user;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: Text(
          userProvider.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
