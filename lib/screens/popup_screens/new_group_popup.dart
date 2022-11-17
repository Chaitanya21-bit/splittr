import 'package:flutter/material.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import 'package:uuid/uuid.dart';

Future<void> newGroup(BuildContext context, Person person) {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController aboutGroupController = TextEditingController();
  final TextEditingController groupLimitController = TextEditingController();
  final TextEditingController personalLimitController = TextEditingController();
  final TextEditingController groupCodeController = TextEditingController();
  addGroup() async {
    try {
      NavigatorState state = Navigator.of(context);
      const uuid = Uuid(); // generate random id
      Group group = Group(
          gid: uuid.v1(),
          groupName: groupNameController.text,
          groupCode: groupCodeController.text,
          groupDescription: aboutGroupController.text);
      await person.addGroup(group);
      state.pop();
    } catch (e) {
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
              onPressed: () => addGroup(),
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
