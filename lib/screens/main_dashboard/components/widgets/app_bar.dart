import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/routes.dart';

class MainDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MainDashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamBG,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Dashboard',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.profile),
          icon: const Icon(Icons.account_circle_sharp),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 40);
}
