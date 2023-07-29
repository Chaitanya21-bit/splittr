import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/components/custom_text_field.dart';
import '../../colors.dart';
import '../../components/background.dart';
import '../../size_config.dart';
import '../../utils/toasts.dart';


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
    amountController.add(TextEditingController(text: "0"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().creamBG,
        foregroundColor: Colors.black,
        title: Align(
          alignment: Alignment.center,
          child: Text('Quick Split',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300
            ),),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.login),
          ),
        ],
        elevation: 0,
      ),
      body: BackgroundStack(
        builder: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.0001,
                  horizontal: SizeConfig.screenWidth * 0.1
                ),
                  child: Image.asset("assets/SplittrLogo.png",height: SizeConfig.screenHeight * 0.06,)
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight * 0.0001,
                      horizontal: SizeConfig.screenWidth * 0.1
                  ),
                  child: const Text("Add Name & Amount",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: totalItem,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top : 15),
                      child: userController(
                          index, nameController[index], amountController[index]),
                    );
                  }
                  ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(

                  onPressed: () => {
                    setState(() {
                      nameController.add(TextEditingController());
                      amountController.add(TextEditingController(text: "0"));
                      totalItem = totalItem + 1;
                    }),
                  },
                  icon: Icon(Icons.add_circle_outline),
                  iconSize: SizeConfig.screenWidth * 0.08,
                ),
              )
            ],
          )
        ),
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton:
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children : [
          FloatingActionButton.extended(
            onPressed: () {
              List<Map> people = [];

              if (nameController.length < 2){
                return showToast("Add More to Split");
              }
              for (int i = 0; i < nameController.length; i++) {
                people.add({
                  'name': nameController[i].text.toString(),
                  'amount': double.parse(amountController[i].text.toString())
                });
              }
              Navigator.pushNamed(context, '/quickSplit', arguments: people);
            },
            label: const Text('Split'),
            foregroundColor: AppColors().black,
            backgroundColor: AppColors().yellow,
          ),
          // FloatingActionButton.extended(
          //   onPressed: () {
          //     setState(() {
          //       nameController.add(TextEditingController());
          //       amountController.add(TextEditingController(text: "0"));
          //       totalItem = totalItem + 1;
          //     });},
          //   label: const Text('Add'),
          //   foregroundColor: AppColors().black,
          //   backgroundColor: AppColors().yellow,
          // ),
        // ]
      // ),
    );
  }
}

Widget userController(int index, TextEditingController name, TextEditingController amount) {
  return ClipRRect(
    child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX:10,sigmaY: 10),
        child: Container(
          color: AppColors().black.withOpacity(0.25),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: InputTextField(
                      controller: name,
                      labelText: "Name",
                      padding : EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                  )
              ),

              Expanded(
                child: InputTextField(
                    controller: amount,
                    labelText: "Amount",
                    textInputAction : TextInputType.number,
                    padding : EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                )
            ),
            ],
          ),
        ),
    ),
  );
}