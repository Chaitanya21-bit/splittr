import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/main.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'package:splitter/utils/auth_utils.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/SignupTop BlobImg.png")
            ),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Text("Sign Up",
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        right: 30,
                        left: 30
                    ),
                    child:
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        labelText: "Email",
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        right: 30,
                        left: 30
                    ),
                    child:
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Name",
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        right: 30,
                        left: 30
                    ),
                    child:
                    TextField(
                      controller: aliasController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Alias",
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        right: 30,
                        left: 30
                    ),
                    child:
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
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        right: 30,
                        left: 30
                    ),
                    child:
                    TextFormField(
                      controller: cnfPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: "Confirm Password",
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.035,
                    ),
                    child:
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
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: 0,
                        bottom: 0,
                    ),
                    child:
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
                  ),
                ],
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset("assets/SignupBottom BlobImg.png"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    NavigatorState state = Navigator.of(context);
    try {
      AuthUtils.showLoadingDialog(context);
      final credentials = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Person person = Person();

      Map<String, dynamic> personJson = {};
      personJson['name'] = nameController.text;
      personJson['uid'] = credentials.user!.uid;
      personJson['alias'] = aliasController.text;
      personJson['email'] = emailController.text;
      personJson['phoneNo'] = "896473";
      personJson['limit'] = -1;

      person.fromJson(personJson);

      await database.ref('Users/${person.uid}').set(person.toJson());
      // state.pop();
      state.pushNamedAndRemoveUntil('home', (Route route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else if (e.code == 'email-already-in-use') {
        state.pop();
        Fluttertoast.showToast(
          msg: "The account already exists for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Invalid details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } catch (e) {
      print(e.toString());
      state.pop();
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
