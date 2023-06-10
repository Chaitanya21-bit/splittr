import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_text_field.dart';
import '../../dataclass/user.dart';
import '../../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User person;

  bool isEditing = false;
  TextEditingController nameEditingController = TextEditingController();

  @override
  void initState() {
    person = Provider.of<UserService>(context, listen: false).user;
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
            InputTextField(controller: nameEditingController, labelText: 'Name')
            : InputTextField(controller: nameEditingController, labelText: 'Name', enable: false),


            ElevatedButton(onPressed: () => { toggle() },
                child: Text(isEditing ? 'Done' : 'Edit')),
          ],
        ));
  }

}
