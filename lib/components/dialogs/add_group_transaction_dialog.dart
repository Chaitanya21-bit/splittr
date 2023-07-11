import 'package:flutter/material.dart';
import 'package:splitter/components/dialogs/split_between_bottom_dialog.dart';
import 'package:splitter/components/dialogs/split_between_popup.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/dataclass.dart';
import '../../providers/category_provider.dart';
import '../../utils/get_provider.dart';
import '../../utils/toasts.dart';
import '../category_dropdown.dart';

class AddGroupTransactionDialog {
  final Map<String, TextEditingController> _payersMap = {};
  late final TextEditingController _addRemarksController;
  late final TextEditingController _addTitleController;
  late final GroupProvider _groupProvider;
  late final Group _group;
  late final User _user;
  late final CategoryProvider _categoryProvider;
  late final DateTimeProvider _dateTimeProvider;
  late final BuildContext context;
  late final GroupTransaction _groupTransaction;

  AddGroupTransactionDialog(this.context) {
    _initProviders();
    _initControllers();
    _groupTransaction = GroupTransaction(
        tid: const Uuid().v1(),
        creatorId: _user.uid,
        title: _addTitleController.text,
        amount: 0,
        date: _dateTimeProvider.selectedDateTime,
        remarks: _addRemarksController.text,
        category: _categoryProvider.selectedCategory ?? "",
        splitBetween: {});
  }

  void _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _group = _groupProvider.getCurrentGroup();
    _dateTimeProvider = getProvider<DateTimeProvider>(context);
    _user = getProvider<UserProvider>(context).user;
    _categoryProvider = getProvider<CategoryProvider>(context);
  }

  void _initControllers() {
    _payersMap[_user.uid] = TextEditingController();
    _addRemarksController = TextEditingController();
    _addTitleController = TextEditingController();
  }

  bool _validate() {
    if (_addTitleController.text.isEmpty) {
      showToast("Please fill title");
      return false;
    }
    for (final controller in _payersMap.values) {
      if (controller.text.isEmpty) {
        showToast("Please fill amount");
        return false;
      }
    }
    return true;
  }

  void _exit() {
    _disposeControllers();
    Navigator.pop(context);
  }

  void _disposeControllers() {
    for (final controller in _payersMap.values) {
      controller.dispose();
    }
    _addRemarksController.dispose();
    _addTitleController.dispose();
  }

  _createTransaction() async {
    if (!_validate()) return;
    NavigatorState state = Navigator.of(context);
    try {
      showLoadingDialog(context);
      // GroupTransaction groupTransaction = GroupTransaction(
      //   tid: tUuid.v1(),
      //   creatorId: _user.uid,
      //   title: _addTitleController.text,
      //   amount: double.parse(_addMoneyController[0].text),
      //   date: _dateTimeProvider.selectedDateTime,
      //   remarks: _addRemarksController.text,
      //   category: "category",
      //   // splitBetween: List<String>.generate(
      //   //     _group.members.length,
      //   //     (index) => _group.members[index].uid)
      //   splitBetween: splitMap(),
      // );
      await _groupProvider.addGroupTransaction(_groupTransaction);

      _dateTimeProvider.setDateTime(DateTime.now());

      addSettelment();

      state.pop();
    } catch (e) {
      debugPrint(e.toString());
    }
    _exit();
  }

  splitMap() {
    List Members = List<String>.generate(
        _group.members.length, (index) => _group.members[index].uid);
    double evenAmount =
        double.parse(_payersMap[_user.uid]!.text) / _group.members.length;
    final evenSplit = {for (var item in Members) item.toString(): evenAmount};
    print(evenSplit);

    //CustomSplit TO DO
    return evenSplit;
  }

  Future<void> addSettelment() async {
    //Update Total Amount
    _group.totalAmount =
        _group.totalAmount + double.parse(_payersMap[_user.uid]!.text);
    //Subtract when delete the transaction

    //Make Group Object and Update in DB
    Group group = Group(
      groupName: _group.groupName,
      gid: _group.gid,
      groupDescription: _group.groupDescription,
      groupLimit: _group.groupLimit,
      link: _group.link,
      totalAmount: _group.totalAmount,
      members: _group.members,
      transactions: _group.transactions,
    );

    //Group
    await _groupProvider.updateGroup(group);

    //Make Matrix in Group
  }

  void show() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Center(
            child: Text(
              'New Payment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
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
                const SizedBox(height: 20),
                const CategoryDropDown(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _addTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextEd(
                  controllers: _payersMap,
                  addMore: () {
                    // _payersMap.add(TextEditingController());
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addRemarksController,
                  decoration: const InputDecoration(
                    labelText: 'Remarks',
                    border: OutlineInputBorder(),
                    // contentPadding:
                    //     EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_payersMap[_user.uid]!.text.isEmpty) {
                      return showToast("Please fill Amount");
                    }
                    if (_addTitleController.text.isEmpty) {
                      return showToast("Please fill Title");
                    }


                    // SplitBetweenDialog(context,
                    //         amount: double.parse(_payersMap[_user.uid]!.text))
                    //     .show();

                    splitBottomSheetDialog(context,
                        amount: double.parse(_payersMap[_user.uid]!.text), title: _addTitleController.text);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff1870B5)),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  child: const Text("Split Between"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: _exit,
              style: ButtonStyle(
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

class TextEd extends StatefulWidget {
  const TextEd({super.key, required this.controllers, required this.addMore});

  final Map<String, TextEditingController> controllers;
  final VoidCallback addMore;

  @override
  State<TextEd> createState() => _TextEdState();
}

class _TextEdState extends State<TextEd> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.controllers.entries.map((e) => TextFormField(
              controller: e.value,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            )),
        TextButton(
            onPressed: () {
              setState(() {
                widget.addMore();
              });
            },
            child: Text("Add")),
      ],
    );
  }
}
