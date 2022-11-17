import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/person.dart';
import '../../dataclass/transactions.dart';

Future addUserTransaction(BuildContext context, Person person) {
  final TextEditingController addMoneyController = TextEditingController();
  final TextEditingController addRemarksController = TextEditingController();
  final TextEditingController addTitleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  addTransaction(BuildContext context) async {
    try {
      if (addTitleController.text.isEmpty || addMoneyController.text.isEmpty) {
        return Fluttertoast.showToast(
            msg: "Please fill the fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white);
      }

      const tUuid = Uuid();
      Transactions newTrans = Transactions(
          date: DateFormat("dd-MM-yyyy HH:mm:ss").format(selectedDate),
          amount: double.parse(addMoneyController.text),
          title: addTitleController.text,
          remarks: addRemarksController.text,
          tid: tUuid.v1());

      await person.addTransaction(newTrans);

      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }

    addTitleController.clear();
    addMoneyController.clear();
    addRemarksController.clear();
  }

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            openDatePicker() {
              return showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime.now())
                  .then((date) {
                if (date == null && date.toString().isEmpty) {
                  return Fluttertoast.showToast(
                      msg: "Please select a date",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white);
                }

                setState(() => selectedDate = date!);
              });
            }

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
                    child: TextFormField(
                      controller: addTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Add Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      horizontalTitleGap: 0.0,
                      trailing:
                          Text(DateFormat("dd-MM-yyyy").format(selectedDate)),
                      leading: const Icon(Icons.date_range),
                      title: TextButton(
                        onPressed: openDatePicker,
                        child: Text(
                          'Choose Date',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                    height: 25,
                  ),
                  TextFormField(
                    controller: addRemarksController,
                    decoration: const InputDecoration(
                      labelText: 'Add Remarks',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  onPressed: () async => {await addTransaction(context)},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff1870B5)),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  child: const Text("ADD"),
                ),
              ],
            );
          },
        );
      });
}
