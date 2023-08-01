import 'package:flutter/material.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/screens/auth_screens/widgets/auth_button.dart';
import 'package:splitter/utils/auth_utils.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../constants/assets.dart';
import '../../utils/size_config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController aliasController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController cnfPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    aliasController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
  }

  Future<void> registerUser(BuildContext context) async {
    showLoadingDialog(context);
    await getProvider<FirebaseAuthProvider>(context).signUpWithEmail(
      context,
      email: emailController.text,
      password: passwordController.text,
      cnfPassword: cnfPasswordController.text,
      name: nameController.text,
      alias: aliasController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(Assets.singUpTop),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(Assets.singUpBottom),
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        InputTextField(controller: emailController, labelText: 'Email'),
        InputTextField(controller: nameController, labelText: 'Name'),
        InputTextField(controller: aliasController, labelText: 'Alias'),
        InputTextField(controller: passwordController, labelText: 'Password'),
        InputTextField(
            controller: cnfPasswordController, labelText: 'Confirm Password'),
        AuthButton(onPressed: () => registerUser(context), text: "Sign Up"),
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
}
