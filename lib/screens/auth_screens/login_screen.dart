import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/dataclass/person.dart';
import '../../auth/firebase_manager.dart';
import '../../main.dart';
import '../../utils/auth_utils.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseManager.auth;
  final FirebaseDatabase database = FirebaseManager.database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                right: 10,
                left: 50,
                bottom: 5,
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset("assets/LoginTop BlobImg.png")), // Logo
            Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                left: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset("assets/SplittrLogo.png")),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset("assets/LoginBottom BlobImg.png")),

            Container(
              margin: const EdgeInsets.all(25),
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36,
                  right: 30,
                  left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => login(context),
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff1870B5)),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: const Text("Login"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an Account ? ",
                      ),
                      TextButton(
                          onPressed: () =>
                              {Navigator.of(context).pushNamed('/signUp')},
                          child: const Text("Sign Up"))
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login(BuildContext context) async {
    NavigatorState state = Navigator.of(context);
    try {
      AuthUtils.showLoadingDialog(context);
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      state.pushNamedAndRemoveUntil('home', (Route route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print("user-not-found");
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else if (e.code == 'wrong-password') {
        print("wrong-password");
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Enter valid details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
      state.pop();
    }
  }
}
