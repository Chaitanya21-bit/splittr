import 'package:flutter/material.dart';
import '../../size_config.dart';


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
      body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.1,
            right: 20,
            left: 20,
            bottom: 5,
          ),
        child:Stack(
          children: [
            Positioned(
                  top: SizeConfig.screenHeight * 0.001,
                  left: SizeConfig.screenWidth * 0.25,
                  width: SizeConfig.screenHeight * 0.2,
                  child: Image.asset("assets/SplittrLogo.png")
            ),
            Positioned(
              top: SizeConfig.screenHeight * 0.12,
              left: SizeConfig.screenWidth * 0,
              child: const Text("Settle Now",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 100,
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

              ],
            )

          ],
        )
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
      const SizedBox(
        height: 7,
      ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 50,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 3,color: Colors.teal),
                    ),
                    labelText: "Name",
                  ),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 170,
                height: 50,
                child: TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 3,color: Colors.teal),
                    ),
                    labelText: "Amount",
                  ),
                ),
              ),
            ],
          ),
    ],

  );
}
