import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/services/firebase_database_service.dart';
import 'package:splitter/utils/auth_utils.dart';
import '../../routes.dart';
import '../../services/firebase_auth_service.dart';
import '../../size_config.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/SignupTop BlobImg.png")),
            buildBody(context),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/SignupBottom BlobImg.png"),
            ),
          ],
        ),
      ),
    );
  }

  Column buildBody(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 30, vertical: 10);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.01,
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
        CustomTextField(controller: emailController, labelText: 'Email', padding: padding,),
        CustomTextField(controller: nameController, labelText: 'Name', padding: padding,),
        CustomTextField(controller: aliasController, labelText: 'Alias', padding: padding,),
        CustomTextField(controller: passwordController, labelText: 'Password', padding: padding,),
        CustomTextField(controller: cnfPasswordController, labelText: 'Confirm Password', padding: padding,),
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.035,
          ),
          child: ElevatedButton(
            onPressed: () => registerUser(context),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff1870B5)),
              overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
            ),
            child: const Text("Sign Up"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an Account ? "),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Sign In"))
            ],
          ),
        ),
      ],
    );
  }

  Future<void> registerUser(BuildContext context) async {
    NavigatorState state = Navigator.of(context);
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    final databaseService =
        Provider.of<FirebaseDatabaseService>(context, listen: false);
    AuthUtils.showLoadingDialog(context);
    final user =
        await authService.signUp(emailController.text, passwordController.text);
    if (user == null) {
      state.pop();
      return;
    }
    Person person = Person(
        uid: user.uid,
        name: nameController.text,
        alias: aliasController.text,
        email: emailController.text,
        phoneNo: "883467",
        groups: [],
        personalTransactions: []);

    await databaseService.set("Users/${person.uid}", person.toJson());
    // state.pushNamedAndRemoveUntil(Routes.home, (Route route) => false);
  }
}
