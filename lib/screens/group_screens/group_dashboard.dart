import 'package:flutter/material.dart';

import '../popup_screens/add_money_popup.dart';

class GroupDashboard extends StatelessWidget {
  const GroupDashboard({Key? key}) : super(key: key);






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openDialogue(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}