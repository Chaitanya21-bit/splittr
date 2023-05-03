import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/components/dialogs/date_picker.dart';
import 'package:splitter/services/datetime_service.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';
import '../../dataclass/person.dart';
import '../../dataclass/transactions.dart';

Future addPersonalTransactionDialog(BuildContext context, Person person) {

  final TextEditingController addMoneyController = TextEditingController();
  final TextEditingController addRemarksController = TextEditingController();
  final TextEditingController addTitleController = TextEditingController();
  final personalTransactionService =
      Provider.of<PersonalTransactionService>(context, listen: false);

  createNewPersonalTransaction() async {
    NavigatorState state = Navigator.of(context);
    final dateTimeService = Provider.of<DateTimeService>(context,listen: false);
    try {
      if (addTitleController.text.isEmpty || addMoneyController.text.isEmpty) {
        return Fluttertoast.showToast(msg: "Please fill the fields");
      }
      AuthUtils.showLoadingDialog(context);
      const tUuid = Uuid();
      PersonalTransaction newTrans = PersonalTransaction(
        date: dateTimeService.selectedDateTime,
        amount: double.parse(addMoneyController.text),
        title: addTitleController.text,
        remarks: addRemarksController.text,
        tid: tUuid.v1(),
        category: 'food',
        userId: person.uid,
      );

      await personalTransactionService.addTransaction(newTrans, person);
      dateTimeService.setDateTime(DateTime.now());
      addTitleController.clear();
      addMoneyController.clear();
      addRemarksController.clear();
      state.pop();
      state.pop();
    } catch (e) {
      addTitleController.clear();
      addMoneyController.clear();
      addRemarksController.clear();
      state.pop();
    }
  }

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {

            return AlertDialog(
              scrollable: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: const Center(
                child: Text('New Payment'),
              ),
              content: Form(
                  child: Column(
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
                    child: const DatePicker(),
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
                  onPressed: createNewPersonalTransaction,
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
