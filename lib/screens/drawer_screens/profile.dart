import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/constants/colors.dart';
import 'package:splitter/utils/size_config.dart';
import '../../components/custom_text_field.dart';
import '../../dataclass/dataclass.dart';
import '../../utils/get_provider.dart';

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
    person = getProvider<UserProvider>(context).user;
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
       backgroundColor: AppColors.creamBG,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: SizedBox(width: SizeConfig.screenWidth,height: 20),
              color: AppColors.yellow,
            ),
            Card(
              child: SizedBox(width: SizeConfig.screenWidth,height: 20),
              color: AppColors.maroon,
            ),
            Card(
              child: SizedBox(width: SizeConfig.screenWidth,height: 20),
              color: AppColors.purple,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),

            InputTextField(controller: nameEditingController, labelText: 'Name', enable: isEditing),


            ElevatedButton(onPressed: () => { toggle() },
                child: Text(isEditing ? 'Done' : 'Edit')),
            Visibility(visible: isEditing,child: ElevatedButton(child: Text('Save'),onPressed: () {} ),)
          ],
        ));
  }

}
