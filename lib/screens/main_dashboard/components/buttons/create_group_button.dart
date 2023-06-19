import 'package:flutter/material.dart';

import '../../../../components/dialogs/dialogs.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({super.key});

  void createGroup(BuildContext context){
    CreateGroupDialog(context).show();
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => createGroup(context),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          backgroundColor: const Color(0xff223146),
          foregroundColor: Colors.white,
          shadowColor: Colors.blueAccent,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            //minimumSize: Size(100, 40),
          )),
      icon: const Text("Create"),
      label: const Icon(Icons.add_circle),
    );
  }
}
