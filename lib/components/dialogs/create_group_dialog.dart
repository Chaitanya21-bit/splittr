import 'package:flutter/material.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:splitter/utils/get_provider.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/dataclass.dart';
import '../../utils/toasts.dart';

class CreateGroupDialog {
  late final TextEditingController _groupNameController;
  late final TextEditingController _aboutGroupController;
  late final TextEditingController _groupLimitController;
  late final TextEditingController _personalLimitController;
  late final BuildContext context;
  late final GroupProvider _groupProvider;
  late final DynamicLinksProvider _dynamicLinksProvider;
  late final User _user;
  late final String _uuid;

  CreateGroupDialog(this.context) {
    _uuid = const Uuid().v1();
    _initControllers();
    _initProviders();
  }

  _initProviders() {
    _groupProvider = getProvider<GroupProvider>(context);
    _dynamicLinksProvider = getProvider<DynamicLinksProvider>(context);
    _user = getProvider<UserProvider>(context).user;
  }

  _initControllers() {
    _groupNameController = TextEditingController();
    _aboutGroupController = TextEditingController();
    _groupLimitController = TextEditingController();
    _personalLimitController = TextEditingController();
  }

  _exit() {
    Navigator.pop(context);
  }

  void createGroup() async {
    if (!_validate()) return;
    try {
      showLoadingDialog(context);
      NavigatorState state = Navigator.of(context);
      Uri link = await _dynamicLinksProvider.createDynamicLink(_uuid);

      Group group = Group(
          gid: _uuid,
          groupName: _groupNameController.text,
          groupDescription: _aboutGroupController.text,
          link: link,
          groupLimit: double.tryParse(_groupLimitController.text),
          totalAmount: 0,
          members: [_user],
          transactions: [],
      );
      await _groupProvider.createGroup(group);
      state.pop();
    } catch (e) {
      showToast("Failed to create Group");
      debugPrint(e.toString());
    }
    _exit();
  }

  bool _validate() {
    if (_groupNameController.text.isEmpty) {
      showToast("Enter Group Name.");
      return false;
    }
    if (_aboutGroupController.text.isEmpty) {
      showToast("Enter About Field.");
      return false;
    }
    if (_groupLimitController.text.isEmpty) {
      showToast("Enter Group Limit.");
      return false;
    }
    if (_personalLimitController.text.isEmpty) {
      showToast("Enter Personal Limit.");
      return false;
    }
    return true;
  }

  void show() {
    showDialog(
        context: context,
        builder: (context) {
          const padding = EdgeInsets.symmetric(vertical: 10);
          return AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Center(
              child: Text('New Group'),
            ),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputTextField(
                    controller: _groupNameController,
                    labelText: 'Group Name',
                    padding: padding,
                  ),
                  InputTextField(
                    controller: _aboutGroupController,
                    labelText: 'About',
                    padding: padding,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          controller: _groupLimitController,
                          labelText: 'Limit',
                          padding: padding,
                          textInputAction: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InputTextField(
                          controller: _personalLimitController,
                          labelText: 'Personal Limit',
                          padding: padding,
                          textInputAction: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: padding,
                    child: Text(_uuid),
                  ),
                ],
              ),
            ),
            actions: [
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
                onPressed: createGroup,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1870B5)),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                child: const Text("Done"),
              ),
            ],
          );
        });
  }
}
