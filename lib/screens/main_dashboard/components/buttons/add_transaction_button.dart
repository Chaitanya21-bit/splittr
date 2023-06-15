import 'package:flutter/material.dart';

import '../../../../components/dialogs/add_personal_transaction_dialog.dart';

class AddPersonalTransactionButton extends StatelessWidget {
  const AddPersonalTransactionButton({super.key});

  void addTransaction(BuildContext context){
    AddPersonalTransactionDialog(context).show();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => addTransaction(context),
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
      icon: const Text("Add"),
      label: const Icon(
        Icons.add_circle,
      ),
    );
  }
}
