import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/components/dialogs/date_picker.dart';
import 'package:splitter/services/datetime_service.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/personalTransactions.dart';
import '../../dataclass/user.dart';

Future addPersonalTransactionDialog(BuildContext context, User person) {
  return showDialog(
      context: context,
      builder: (context) {
        final TextEditingController addMoneyController =
            TextEditingController();
        final TextEditingController addRemarksController =
            TextEditingController();
        final TextEditingController addTitleController =
            TextEditingController();
        final personalTransactionService =
            Provider.of<PersonalTransactionService>(context, listen: false);
        final dateTimeService =
        Provider.of<DateTimeService>(context, listen: false);
        createNewPersonalTransaction() async {
          if (addTitleController.text.isEmpty ||
              addMoneyController.text.isEmpty) {
            return Fluttertoast.showToast(msg: "Please fill the fields");
          }
          NavigatorState state = Navigator.of(context);
          try {
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
            state.pop();
          } catch (e) {
            print(e.toString());
          }
          addTitleController.dispose();
          addMoneyController.dispose();
          addRemarksController.dispose();
          state.pop();
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
            children: [
              InputTextField(
                controller: addTitleController,
                labelText: 'Add Title',
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: DatePicker(),
              ),
              InputTextField(
                controller: addMoneyController,
                labelText: 'Add Money',
                textInputAction: TextInputType.number,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              InputTextField(
                controller: addRemarksController,
                labelText: 'Add Remarks',
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ],
          )),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
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
      });
}
