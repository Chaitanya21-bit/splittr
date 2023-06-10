import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/services/dynamic_link_service.dart';
import 'package:splitter/services/group_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:uuid/uuid.dart';

import '../../dataclass/group.dart';
import '../../dataclass/user.dart';

Future<void> createGroupDialog(BuildContext context, User user) {
  return showDialog(
      context: context,
      builder: (context) {
        const padding = EdgeInsets.symmetric(vertical: 10);
        final TextEditingController groupNameController =
            TextEditingController();
        final TextEditingController aboutGroupController =
            TextEditingController();
        final TextEditingController groupLimitController =
            TextEditingController();
        final TextEditingController personalLimitController =
            TextEditingController();
        final TextEditingController groupLinkController =
            TextEditingController();

        final groupService = Provider.of<GroupService>(context, listen: false);
        final dynamicLinkService =
            Provider.of<DynamicLinkService>(context, listen: false);

        addGroup() async {
          try {
            AuthUtils.showLoadingDialog(context);
            NavigatorState state = Navigator.of(context);
            String uuid = const Uuid().v1();
            Uri link = await dynamicLinkService.createDynamicLink(uuid);
            Group group = Group(
                gid: uuid,
                groupName: groupNameController.text,
                groupDescription: aboutGroupController.text,
                link: link,
                groupLimit: double.tryParse(groupLimitController.text),
                totalAmount: 0,
                members: [user]);
            await groupService.addGroup(group, user);
            groupNameController.dispose();
            aboutGroupController.dispose();
            groupLimitController.dispose();
            personalLimitController.dispose();
            groupLinkController.dispose();
            state.pop();
            state.pop();
          } catch (e) {
            Fluttertoast.showToast(msg: "Failed to create Group");
            debugPrint(e.toString());
          }
        }

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
                  controller: groupNameController,
                  labelText: 'Group Name',
                  padding: padding,
                ),
                InputTextField(
                  controller: aboutGroupController,
                  labelText: 'About',
                  padding: padding,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        controller: groupLimitController,
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
                        controller: personalLimitController,
                        labelText: 'Personal Limit',
                        padding: padding,
                        textInputAction: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                InputTextField(
                  controller: groupLinkController,
                  labelText: 'Generated Link',
                  padding: padding,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async => await addGroup(),
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
