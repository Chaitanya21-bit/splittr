import 'package:flutter/material.dart';

import '../../auth/firebase_manager.dart';
import '../auth_screens/login_screen.dart';

class QuickSettle extends StatefulWidget {
  const QuickSettle({Key? key}) : super(key: key);

  @override
  State<QuickSettle> createState() => _QuickSettleState();
}

class _QuickSettleState extends State<QuickSettle> {
  int totalItem = 1;
  List<TextEditingController> nameController = [];
  List<TextEditingController> amountController = [];

  @override
  void initState() {
    nameController.add(TextEditingController());
    amountController.add(TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Settle'),
        centerTitle: true,
        backgroundColor: const Color(0xff1870B5),
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
        child: Column(children: [
          const Text(
            "Quick Settle",
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: totalItem,
              itemBuilder: (context, index) {
                return userController(
                    index, nameController[index], amountController[index]);
              }),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                nameController.add(TextEditingController());
                amountController.add(TextEditingController());
                totalItem = totalItem + 1;
              }),
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff1870B5)),
              overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
            ),
            child: const Text("Add"),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(nameController);
          print(amountController);
          var s = 0;
          for (var e in amountController) {
            s += int.parse(e.text);
          }
          print(s);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: const Color(0xff1870B5),
        child: const Icon(Icons.monetization_on, color: Colors.black, size: 55),
      ),
    );
  }
}

Widget userController(
    int index, TextEditingController name, TextEditingController amount) {
  return Column(
    children: [
      const SizedBox(
        height: 15,
      ),
      TextField(
        controller: name,
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
        controller: amount,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: "Amount",
        ),
      ),
    ],
  );
}
