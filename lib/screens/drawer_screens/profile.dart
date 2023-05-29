import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/firebase_manager.dart';
import '../../components/custom_text_field.dart';
import '../../dataclass/person.dart';
import '../auth_screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Person person;

  bool isEditing = false;
  TextEditingController nameEditingController = TextEditingController();

  @override
  void initState() {
    person = Provider.of<Person>(context, listen: false);
    super.initState();
    nameEditingController = TextEditingController(text: person.name);
  }


  toggle() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),

            isEditing ?
            CustomTextField(controller: nameEditingController, labelText: 'Name')
            : CustomTextField(controller: nameEditingController, labelText: 'Name', enable: false),


            ElevatedButton(onPressed: () => { toggle() },
                child: Text(isEditing ? 'Done' : 'Edit')),
          ],
        ));
  }

}
