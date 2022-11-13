import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/main.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/main_dashboard.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseManager.auth;
  final FirebaseDatabase database = FirebaseManager.database;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                right: 10,
                left: 50,
              ),
            ),

            Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/SignupTop BlobImg.png")),
            // Logo
            Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset("assets/WhiteSplittrLogo.png")),

            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset("assets/SignupBottom BlobImg.png"),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  right: 30,
                  left: 30),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 25,
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
                    height: 15,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: "Name",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: aliasController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: "Alias",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                    height: 15,
                  ),
                  TextField(
                    controller: cnfPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: "Confirm Password",
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () => registerUser(context),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff1870B5)),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: const Text("Sign Up"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account ? "),
                      TextButton(
                          onPressed: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()))
                              },
                          child: const Text("Sign In"))
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      NavigatorState state = Navigator.of(context);
      final credentials = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Map<String, dynamic> j = {};
      j['name'] = nameController.text;
      j['uid'] = credentials.user!.uid;
      j['alias'] = aliasController.text;
      j['email'] = emailController.text;
      j['phoneNo'] = "896473";
      j['limit'] = -1;
      Person person = Person();
      person.fromJson(j);

      await database.ref('Users/${person.uid}').set(person.toJson());
      state.pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
