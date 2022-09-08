import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splitter/auth/firebase_manager.dart';
import 'package:splitter/main.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseManager.auth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.fitHeight),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  right: 10,
                  left: 50,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                      right: 30,
                      left: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: nameController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: aliasController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelText: "Alias",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () => registerUser(context),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1870B5)),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: const Text("Sign Up"),
                      ),
                      Row(
                        children: [
                          const Text("Already have an Account ? "),
                          TextButton(
                              onPressed: () => { Navigator.of(context).push(
                                  MaterialPageRoute( builder: (context) => LoginScreen()))
                              },
                              child: const Text("Sign In"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      NavigatorState state = Navigator.of(context);
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      state.pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "title")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
