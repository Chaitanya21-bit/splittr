import 'package:flutter/material.dart';
import 'package:splitter/components/dialogs/dialogs.dart';
import 'package:splitter/utils/get_provider.dart';

class JoinGroupButton extends StatelessWidget {
  const JoinGroupButton({super.key});

  void joinGroup(BuildContext context){
    getProvider<JoinGroupProvider>(context).show(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => joinGroup(context),
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
          )),
      icon: const Text("Join"),
      label: const Icon(
        Icons.add_circle,
      ),
    );
  }
}
