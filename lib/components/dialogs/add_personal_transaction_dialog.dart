import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/components/dialogs/date_picker.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/dataclass.dart';
import '../../utils/get_provider.dart';

class AddPersonalTransactionDialog {
  late final TextEditingController _addMoneyController;
  late final TextEditingController _addRemarksController;
  late final TextEditingController _addTitleController;
  late final PersonalTransactionProvider _personalTransactionProvider;
  late final DateTimeProvider _dateTimeService;
  late final User _user;
  late final BuildContext context;

  AddPersonalTransactionDialog(this.context) {
    _initControllers();
    _initProviders();
  }

  void _initProviders() {
    _personalTransactionProvider =
        getProvider<PersonalTransactionProvider>(context);
    _dateTimeService = getProvider<DateTimeProvider>(context);
    _user = getProvider<UserProvider>(context).user;
  }

  void _initControllers() {
    _addMoneyController = TextEditingController();
    _addRemarksController = TextEditingController();
    _addTitleController = TextEditingController();
  }

  bool _validate() {
    if (_addTitleController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill title");
      return false;
    }
    if (_addMoneyController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill email");
      return false;
    }
    return true;
  }

  _exit() {
    Navigator.pop(context);
  }

  _createTransaction() async {
    if (!_validate()) return;
    NavigatorState state = Navigator.of(context);
    try {
      AuthUtils.showLoadingDialog(context);
      const tUuid = Uuid();
      PersonalTransaction newTransaction = PersonalTransaction(
        date: _dateTimeService.selectedDateTime,
        amount: double.parse(_addMoneyController.text),
        title: _addTitleController.text,
        remarks: _addRemarksController.text,
        tid: tUuid.v1(),
        category: 'food',
        userId: _user.uid,
      );

      await _personalTransactionProvider.addTransaction(newTransaction);
      _dateTimeService.setDateTime(DateTime.now());
      state.pop();
    } catch (e) {
      debugPrint(e.toString());
    }
    _exit();
  }

  show() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: const Center(
            child: Text('New Payment'),
          ),
          content: Form(
            child: Column(
              children: [
                InputTextField(
                  controller: _addTitleController,
                  labelText: 'Add Title',
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: DatePicker(),
                ),
                InputTextField(
                  controller: _addMoneyController,
                  labelText: 'Add Money',
                  textInputAction: TextInputType.number,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                InputTextField(
                  controller: _addRemarksController,
                  labelText: 'Add Remarks',
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: _exit,
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _createTransaction,
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
  }
}
