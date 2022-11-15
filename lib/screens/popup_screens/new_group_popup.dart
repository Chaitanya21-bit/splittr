import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/screens/main_dashboard.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../../auth/firebase_manager.dart';

final FirebaseDatabase database = FirebaseManager.database;
final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController groupNameController = TextEditingController();
final TextEditingController aboutGroupController = TextEditingController();
final TextEditingController groupLimitController = TextEditingController();
final TextEditingController personalLimitController = TextEditingController();
final TextEditingController groupCodeController = TextEditingController();

Future<void> newGroup(BuildContext context, Person P) {
  addGroup(BuildContext context) async {
    try {
      NavigatorState state = Navigator.of(context);
      const uuid = Uuid(); // generate random id
      Group group = Group(
          gid: uuid.v1(),
          groupName: groupNameController.text,
          groupCode: groupCodeController.text,
          groupDescription: aboutGroupController.text);
      group.members.add(P);
      print("Group Created");
      await database.ref('Group/${group.gid}').set(group.toJson());
      print("Group Stored");
      P.userGroups.add(group);

      await database.ref('Users/${_auth.currentUser?.uid}').update(P.toJson());
      print("User Upated");
      state.pop();
    } catch (e) {
      print(e);
    }
    groupNameController.clear();
    groupLimitController.clear();
    aboutGroupController.clear();
    groupCodeController.clear();
    personalLimitController.clear();
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
                controller: groupCodeController,
                decoration: const InputDecoration(
                  labelText: 'Generated Code',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
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
              onPressed: () => addGroup(context),
              // {Navigator.of(context).push(MaterialPageRoute( builder: (context) => GroupDashboard()))},
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
