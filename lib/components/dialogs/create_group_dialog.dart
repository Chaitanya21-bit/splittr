import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/services/dynamic_link_service.dart';
import 'package:splitter/services/group_service.dart';
import 'package:splitter/services/user_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:splitter/utils/get_provider.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/group.dart';
import '../../dataclass/user.dart';

class CreateGroupDialog {
  late final TextEditingController _groupNameController;
  late final TextEditingController _aboutGroupController;
  late final TextEditingController _groupLimitController;
  late final TextEditingController _personalLimitController;
  late final BuildContext context;
  late final GroupService _groupService;
  late final DynamicLinkService _dynamicLinkService;
  late final User _user;

  CreateGroupDialog(this.context) {
    _initControllers();
    _initProviders();
  }

  _initControllers() {
    _groupNameController = TextEditingController();
    _aboutGroupController = TextEditingController();
    _groupLimitController = TextEditingController();
    _personalLimitController = TextEditingController();
  }

  _exit(){
    Navigator.pop(context);
  }

  _initProviders(){
    _groupService = getProvider<GroupService>(context);
    _dynamicLinkService = getProvider<DynamicLinkService>(context);
    _user = getProvider<UserService>(context).user;
  }

  void createGroup() async {
    if(!_validate()) return;
    try {
      AuthUtils.showLoadingDialog(context);
      NavigatorState state = Navigator.of(context);
      String uuid = const Uuid().v1();
      Uri link = await _dynamicLinkService.createDynamicLink(uuid);
      Group group = Group(
          gid: uuid,
          groupName: _groupNameController.text,
          groupDescription: _aboutGroupController.text,
          link: link,
          groupLimit: double.tryParse(_groupLimitController.text),
          totalAmount: 0,
          members: [_user]);
      await _groupService.addGroup(group, _user);
      state.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to create Group");
      debugPrint(e.toString());
    }
    _exit();
  }

  bool _validate(){
    if(_groupNameController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter Group Name.");
      return false;
    }
    if(_aboutGroupController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter About Field.");
      return false;
    }
    if(_groupLimitController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter Group Limit.");
      return false;
    }
    if(_personalLimitController.text.isEmpty){
      Fluttertoast.showToast(msg: "Enter Personal Limit.");
      return false;
    }
    return true;
  }

  void show(){
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
                  // InputTextField(
                  //   controller: groupLinkController,
                  //   labelText: 'Generated Link',
                  //   padding: padding,
                  // ),
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

