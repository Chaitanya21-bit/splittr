import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../auth_screens/login_screen.dart';

class QuickSettle extends StatefulWidget {
  const QuickSettle({Key? key}) : super(key: key);

  @override
  State<QuickSettle> createState() => _QuickSettleState();
}

class _QuickSettleState extends State<QuickSettle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quick Settle'),
          centerTitle: true,
          backgroundColor: Color(0xff1870B5),
          actions: [
              IconButton(
                  onPressed: () {
                      FirebaseManager.auth.signOut();
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                  icon: const Icon(Icons.logout))
              ],
    ),

            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 20,
                left: 20,
                bottom: 5,
              ),

              child: Column(
                      children: [
                        const Text(
                          "Quick Settle",
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                        userController(),
                        ElevatedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xff1870B5)),
                            overlayColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                          ),
                          child: const Text("Add"),
                        ),
                ]
                ),
                ),
    );
  }
}


Widget userController (){
  return Column(
    children:[
      const SizedBox(
        height: 15,
      ),
      TextField(
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
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: "Amount",
        ),
      ),
    ] ,
  );
}