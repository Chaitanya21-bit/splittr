import 'package:flutter/material.dart';
import 'package:splitter/services/firebase_auth_service.dart';
import '../../components/custom_text_field.dart';
import '../../constants/routes.dart';
import '../../size_config.dart';
import '../../utils/auth_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/LoginTop BlobImg.png"), // Logo,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/SplittrLogo.png",
                    width: SizeConfig.screenHeight * 0.2,
                  )
              ),
              buildBody(context),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/LoginBottom BlobImg.png"), // Logo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.04,
          ),
          child: const Text("Login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
          ),
        ),
        InputTextField(controller: emailController, labelText: 'Email'),
        InputTextField(controller: passwordController, labelText: 'Password'),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          child: ElevatedButton(
            onPressed: () => login(context),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(const Color(0xff1870B5)),
              overlayColor:
              MaterialStateProperty.all<Color>(Colors.pink),
            ),
            child: const Text("Login"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an Account ? ",
              ),
              TextButton(
                  onPressed: () =>Navigator.of(context).pushNamed(Routes.singUp),
                  child: const Text("Sign Up"))
            ],
          ),
        ),

      ],
    );
  }

  login(BuildContext context) async {
    AuthUtils.showLoadingDialog(context);
    await FirebaseAuthService.signInWithEmail(
        email: emailController.text, password: passwordController.text);
  }
}


