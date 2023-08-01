import 'package:flutter/material.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/screens/auth_screens/widgets/auth_button.dart';
import 'package:splitter/utils/get_provider.dart';

import '../../components/custom_text_field.dart';
import '../../constants/assets.dart';
import '../../constants/routes.dart';
import '../../utils/auth_utils.dart';
import '../../utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    showLoadingDialog(context);
    await getProvider<FirebaseAuthProvider>(context).signInWithEmail(
      context,
      email: emailController.text,
      password: passwordController.text,
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
                child: Image.asset(Assets.loginTop),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(Assets.loginBottom),
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        InputTextField(controller: emailController, labelText: 'Email'),
        InputTextField(controller: passwordController, labelText: 'Password'),
        AuthButton(onPressed: () => login(context), text: "Login"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an Account ? "),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.signUp),
              child: const Text("Sign Up"),
            )
          ],
        ),
      ],
    );
  }
}
