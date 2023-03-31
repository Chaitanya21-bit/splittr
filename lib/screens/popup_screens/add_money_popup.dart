import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/widgets/what_for_dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../dataclass/group.dart';
import '../../dataclass/transactions.dart';
import '../../utils/auth_utils.dart';

Future<void> openDialogue(BuildContext context, Group group,Person person) async {
  final TextEditingController addMoneyController =
  TextEditingController();
  final TextEditingController addRemarksController =
  TextEditingController();

  addTransaction(BuildContext context) async {
    try {
      if (addRemarksController.text.isEmpty || addMoneyController.text.isEmpty) {
        return Fluttertoast.showToast(
            msg: "Please fill the fields");
      }
      AuthUtils.showLoadingDialog(context);
      const tUuid = Uuid();
      Transactions newTrans = Transactions(
          date: DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now()),
          amount: double.parse(addMoneyController.text),
          title: "addTitleController.text",
          remarks: addRemarksController.text,
          tid: tUuid.v1(), split: [person], category: 'Lalal', authorId: person.uid, isGroup: true);

      await person.addTransaction(newTrans);
      await group.addTransaction(newTrans,person);

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
    addMoneyController.clear();
    addRemarksController.clear();
  }

  return await showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Center(
            child: Text('New Payment'),
          ),
          content: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(group.groupName),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [Expanded(child: WhatForDropdown())],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: addMoneyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Add money',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: addRemarksController,
                decoration: const InputDecoration(
                  labelText: 'Add Remarks',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 30),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => {},
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("Split Between"),
              ),
            ],
          )),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => {addTransaction(context)},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("ADD"),
            ),
          ],
        );
      });
}
