import 'package:flutter/material.dart';
import 'package:splitter/main.dart';
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

          const SizedBox(
            height: 15,
          ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
              List<Map> people = [];

              for (int i = 0; i < nameController.length; i++) {
                people.add({
                  'name': nameController[i].text.toString(),
                  'amount': double.parse(amountController[i].text.toString())
                });
              }
              Navigator.pushNamed(context, '/quickSplit', arguments: people);
        },
        label: const Text('Split'),
        // icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

Widget userController(
    int index, TextEditingController name, TextEditingController amount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 11,
      ),
      Container(
            width: 40,
            height: 40,
            decoration: new BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
      const SizedBox(
        height: 7,
      ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Name",
                  ),
                ),
              ),
              SizedBox(width: 30,),
              SizedBox(
                width: 150,
                child: TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Amount",
                  ),
                ),
              )
            ],
          ),



    ],

  );
}
