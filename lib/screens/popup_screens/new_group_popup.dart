import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/utils/auth_utils.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import 'package:uuid/uuid.dart';

Future<void> newGroup(BuildContext context, Person person) {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController aboutGroupController = TextEditingController();
  final TextEditingController groupLimitController = TextEditingController();
  final TextEditingController personalLimitController = TextEditingController();
  final TextEditingController groupLinkController = TextEditingController();

  Future<Uri> createDynamicLink(String id) async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: 'https://splittrflutter.page.link',
        link: Uri.parse('https://splittrflutter.page.link.com/?id=$id'),
        androidParameters: const AndroidParameters(
          packageName: 'com.example.splitter',
          minimumVersion: 1,
        ),
        iosParameters: const IOSParameters(bundleId: 'com.example.splitter'));
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl;
  }

  addGroup() async {
    try {
      AuthUtils.showLoadingDialog(context);
      NavigatorState state = Navigator.of(context);
      String uuid = const Uuid().v1(); // generate random id
      Uri link = await createDynamicLink(uuid);
      Group group = Group(
          gid: uuid,
          groupName: groupNameController.text,
          groupDescription: aboutGroupController.text,
          link: link);
      // await person.addGroup(group);
      state.pop();
      state.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to create Group");
      print(e);
    }
  }

  return showDialog(
      context: context,
      builder: (context) {

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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: groupNameController,
                  decoration: const InputDecoration(
                    labelText: 'Group Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: aboutGroupController,
                  decoration: const InputDecoration(
                    labelText: 'About',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: groupLimitController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Group Limit',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: personalLimitController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Personal Limit',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  readOnly: true,
                  controller: groupLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Generated Link',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
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
