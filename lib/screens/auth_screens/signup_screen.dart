import 'package:flutter/material.dart';
import 'package:splitter/components/custom_text_field.dart';
import 'package:splitter/screens/auth_screens/signup_screen_controller.dart';
import 'package:splitter/screens/auth_screens/widgets/auth_button.dart';
import 'package:splitter/screens/base.dart';

import '../../constants/assets.dart';
import '../../utils/size_config.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpScreenController controller;

  @override
  void initState() {
    controller = SignUpScreenController(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      controller: controller,
      builder: (context, controller, _) => Scaffold(
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
        InputTextField(
            controller: controller.emailController, labelText: 'Email'),
        InputTextField(
            controller: controller.nameController, labelText: 'Name'),
        InputTextField(
            controller: controller.aliasController, labelText: 'Alias'),
        InputTextField(
            controller: controller.passwordController, labelText: 'Password'),
        InputTextField(
            controller: controller.cnfPasswordController,
            labelText: 'Confirm Password'),
        AuthButton(onPressed: controller.submit, text: "Sign Up"),
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
