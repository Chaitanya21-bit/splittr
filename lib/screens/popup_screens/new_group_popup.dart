import 'package:flutter/material.dart';
import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import '../group_screens/group_dashboard.dart';
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


Future<void> newGroup(BuildContext context) async{
  return await showDialog(context: context,
      builder: (context){
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(child: Text('New Group'),),
          content: Form(

              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller:groupNameController ,
                    decoration: const InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    controller:aboutGroupController ,
                    decoration: const InputDecoration(
                      labelText: 'About',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children:  [
                    Expanded(
                      child: TextFormField(
                        controller:groupLimitController ,
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
                        controller:personalLimitController ,
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
                    decoration: const InputDecoration(
                      labelText: 'Generated Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              )
          ),
          actions: <Widget>[

            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),


            ElevatedButton(
              onPressed: () => addGroup(context),
              // {Navigator.of(context).push(MaterialPageRoute( builder: (context) => GroupDashboard()))},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Done"),
            ),
          ],
        );
      });

}

addGroup(BuildContext context) async{
  try{
    NavigatorState state = Navigator.of(context);

    Person P;
    print(_auth.currentUser?.uid );

    final snapshot = await database.ref().child('Users/${_auth.currentUser!.uid}').get();
    print(snapshot.value);

    Map<String, dynamic> map = Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
    P = Person.fromJson(map);

    // Person P = Person.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
    print(P.userGroups);
//Convert to String to update
    // print(user_groups);


    const uuid = Uuid(); // generate random id
    Group group = Group(
      gid: uuid.v1(),
      groupName: groupNameController.text,
      groupCode: aboutGroupController.text,
      members: [_auth.currentUser!.uid],
    );
    print("Group Created");
    await database.ref('Group/${group.gid}').set(group.toJson());
    print("Group Stored");

    P.userGroups.add(group.gid);

    // var ug = Map<String, dynamic>.from(user_groups as Map); //Convert back to Map

    await database.ref('Users/${_auth.currentUser?.uid}').update(P.toJson());
    print("User Upated");


    state.pushReplacement(
        MaterialPageRoute(builder: (context) => GroupDashboard())
    );
  }

  catch (e) {
    print(e);
  }
}
