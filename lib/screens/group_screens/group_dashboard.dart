import 'package:flutter/material.dart';

class GroupDashboard extends StatelessWidget{
  @override
  Widget build(BuildContext){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.fitHeight),
      ),
    );
  }

}