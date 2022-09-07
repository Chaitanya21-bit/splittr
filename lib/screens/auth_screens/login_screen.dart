import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/firebase_manager.dart';
import '../../main.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  top: MediaQuery.of(context).size.height * 0.4,
                  right: 10,
                  left: 50,
                  bottom: 5,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
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
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1870B5)),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.pink),
                        ),
                        child: const Text("Login"),
                      ),
                      Row(
                        children: [
                          const Text("Don't have an Account ? "),
                          TextButton(
                              onPressed: () => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()))
                                  },
                              child: const Text("Sign Up"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  login(BuildContext context) async {
    try {
      NavigatorState state = Navigator.of(context);
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      state.pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "title")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
