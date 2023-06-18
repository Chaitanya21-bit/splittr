import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/components/dialogs/date_picker.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/dataclass.dart';
import '../../utils/get_provider.dart';
import '../what_for_dropdown.dart';

class AddGroupTransactionDialog {
  late final TextEditingController _addMoneyController;
  late final TextEditingController _addRemarksController;
  late final TextEditingController _addTitleController;
  late final GroupProvider _groupProvider;
  late final Group _group;
  late final User _user;
  late final DateTimeProvider _dateTimeProvider;
  late final BuildContext context;

  AddGroupTransactionDialog(this.context) {
    _initControllers();
    _initProviders();
  }

  void _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _group = _groupProvider.getCurrentGroup();
    _dateTimeProvider = getProvider<DateTimeProvider>(context);
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
      GroupTransaction groupTransaction = GroupTransaction(
          tid: tUuid.v1(),
          creatorId: _user.uid,
          title: _addTitleController.text,
          amount: double.parse(_addMoneyController.text),
          date: _dateTimeProvider.selectedDateTime,
          remarks: _addRemarksController.text,
          category: "category",
          splitBetween: List<String>.generate(
              _group.members.length,
              (index) => _group.members[index].uid));
      await _groupProvider.addGroupTransaction(groupTransaction);

      _dateTimeProvider.setDateTime(DateTime.now());
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
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(
            child: Text('New Payment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
          ),
          content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(_group.groupName),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Category :'),
                      Expanded(child: WhatForDropdown())
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addMoneyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addRemarksController,
                    decoration: const InputDecoration(
                      labelText: 'Remarks',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
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