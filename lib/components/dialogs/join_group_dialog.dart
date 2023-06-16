import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/providers/group_provider.dart';
import 'package:splitter/services/group_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../dataclass/group.dart';
import '../../dataclass/user.dart';
import '../custom_text_field.dart';

class JoinGroupProvider extends ChangeNotifier {
  late final TextEditingController _groupCodeController;
  late final GroupService _groupService;
  late final GroupProvider _groupProvider;
  late final BuildContext context;
  Group? _group;

  Group? get group => _group;
  bool get isGroupPresent => _group != null;

  TextEditingController get groupCodeController => _groupCodeController;

  JoinGroupProvider(this.context) {
    _groupCodeController = TextEditingController();
    _groupService = GroupService();
    _groupProvider = getProvider<GroupProvider>(context);
  }

  bool _validate() {
    return _groupCodeController.text.isNotEmpty;
  }

  Future<void> searchGroup(BuildContext context) async {
    if (!_validate()) {
      Fluttertoast.showToast(msg: "Enter a code");
      return;
    }
    AuthUtils.showLoadingDialog(context);
    _group = await _groupService.getGroupFromDatabase(_groupCodeController.text);
    notifyListeners();
    if(context.mounted){
      Navigator.pop(context);
    }
  }

  joinGroup(BuildContext context) async {
    AuthUtils.showLoadingDialog(context);
    await _groupProvider.joinGroup(_group!);
    if(context.mounted){
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  exit(BuildContext context) {
    _group = null;
    _groupCodeController.clear();
    Navigator.pop(context);
  }

  show(BuildContext context, String? gid) async {
    if(gid != null){
      _groupCodeController.text = gid;
      await searchGroup(context);
    }
    if(context.mounted){
      showDialog(
        context: context,
        builder: (context) {
          return const JoinGroupWidget();
        },
      );
    }

  }
}

class JoinGroupWidget extends StatelessWidget {
  const JoinGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final joinGroupProvider =
        getProvider<JoinGroupProvider>(context, listen: true);
    return AlertDialog(
      scrollable: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Center(
        child: Text(joinGroupProvider.isGroupPresent
            ? 'Do you want to join this group?'
            : 'Search Group'),
      ),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(joinGroupProvider.group?.groupName ?? 'Group Name'),
            ),
            InputTextField(
              controller: joinGroupProvider.groupCodeController,
              labelText: 'Add Code',
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => joinGroupProvider.exit(context),
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
            backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
            overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
          ),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => joinGroupProvider.isGroupPresent ? joinGroupProvider.joinGroup(context): joinGroupProvider.searchGroup(context),
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
            backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
            overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
          ),
          child: Text(joinGroupProvider.isGroupPresent ?"Join" : "Search"),
        ),
      ],
    );
  }
}

Future<void> joinGroup(BuildContext context, User person) async {
  // joinInGroup(BuildContext context) async {
  //   print('He');
  //   try {
  //     NavigatorState state = Navigator.of(context);
  //     Group group;
  //     final grpSnapshot = await database
  //         .ref()
  //         .child('Group/${groupCodeController.text.toString()}')
  //         .get();
  //     print(grpSnapshot.value);
  //     print(groupCodeController.text);
  //     Map<String, dynamic> map =
  //         Map<String, dynamic>.from(grpSnapshot.value as Map<dynamic, dynamic>);
  //     print('Hello');
  //     group = await Group.fromJson(map);
  //     // await group.retrieveMembers(List.of(map['members'].cast<String>()));
  //     // await person.addGroup(group);
  //     state.pushReplacementNamed('/grpDash', arguments: group);
  //   } catch (e) {
  //     print(e);
  //     print('Hell');
  //   }
  // }
}

Future<void> wantToJoin(BuildContext context, User person, Group group) async {
  joinInGroup(BuildContext context) async {
    try {
      AuthUtils.showLoadingDialog(context);
      // if (person.groups.indexWhere((element) => element.gid == group.gid) ==
      //     -1) {
      //   print("Not Exists");
      //   // await person.addGroup(group);
      //   Navigator.pop(context);
      // } else {
      //   print("Exits");
      //   Fluttertoast.showToast(msg: "Already Joined");
      // }
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
