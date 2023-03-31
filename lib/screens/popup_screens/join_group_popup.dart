import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/utils/auth_utils.dart';
import '../../auth/firebase_manager.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';

Future<void> joinGroup(BuildContext context, Person person) async {
  final TextEditingController groupCodeController = TextEditingController();
  final FirebaseDatabase database = FirebaseManager.database;

  joinInGroup(BuildContext context) async {
    print('He');
    try {
      NavigatorState state = Navigator.of(context);
      Group group;
      final grpSnapshot = await database
          .ref()
          .child('Group/${groupCodeController.text.toString()}')
          .get();
      print(grpSnapshot.value);
      print(groupCodeController.text);
      Map<String, dynamic> map =
          Map<String, dynamic>.from(grpSnapshot.value as Map<dynamic, dynamic>);
      print('Hello');
      group = await Group.fromJson(map);
      await group.retrieveMembers(List.of(map['members'].cast<String>()));
      await person.addGroup(group);
      state.pushReplacementNamed('/grpDash', arguments: group);
    } catch (e) {
      print(e);
      print('Hell');
    }
  }

  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Center(
            child: Text('Join Group'),
          ),
          content: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text('Group Name'),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: groupCodeController,
                decoration: const InputDecoration(
                  labelText: 'Add Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
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
              onPressed: () => joinInGroup(context),
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Join"),
            ),
          ],
        );
      });
}

Future<void> wantToJoin(
    BuildContext context, Person person, Group group) async {
  joinInGroup(BuildContext context) async {
    try {
      AuthUtils.showLoadingDialog(context);
      if (person.userGroups.indexWhere((element) => element.gid == group.gid) ==
          -1) {
        print("Not Exists");
        await person.addGroup(group);
        Navigator.pop(context);
      } else {
        print("Exits");
        Fluttertoast.showToast(msg: "Already Joined");
      }
      Navigator.pop(context);
      // state.pushReplacementNamed('/grpDash', arguments: group);
    } catch (e) {
      print(e);
    }
  }

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Center(
            child: Text('Do you want to join the Group?'),
          ),
          content: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(group.groupName),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: group.gid,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
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
              onPressed: () => joinInGroup(context),
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Join"),
            ),
          ],
        );
      });
}
