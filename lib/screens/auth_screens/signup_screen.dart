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
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
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
                  child: Image.asset("assets/SignupTop BlobImg.png")
              ),
              // Logo
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width*0.3,
                  width:MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset("assets/WhiteSplittrLogo.png")
              ),

              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset("assets/SignupBottom BlobImg.png"),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.265,
                      right: 30,
                      left: 30),
                  child: Column(

                    // mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 15,
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
                        obscureText: true,
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
                        obscureText: true,
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
                        height: 15,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account ? "),
                          TextButton(
                              onPressed: () => { Navigator.of(context).push(
                                  MaterialPageRoute( builder: (context) => LoginScreen()))
                              },
                              child: const Text("Sign In"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),


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
