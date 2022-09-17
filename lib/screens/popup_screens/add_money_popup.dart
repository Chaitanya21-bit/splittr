
import 'package:flutter/material.dart';
import 'package:splitter/screens/popup_screens/what_for_dropdown.dart';

Future<void> openDialogue(BuildContext context) async{

  return await showDialog(context: context,
      builder: (context){
        final TextEditingController addMoneyController = TextEditingController();
        final TextEditingController addRemarksController = TextEditingController();
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Center(child: Text('New Payment'),),
          content: Form(

              child: Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(child: Text('Group Name'),),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:  const [
                       Expanded(child: WhatForDropdown())
                  ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  TextFormField(

                    controller:addMoneyController ,

                    decoration: const InputDecoration(
                      labelText: 'Add money',
                      border: OutlineInputBorder(),
                    ),

                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(

                    controller:addRemarksController ,
                    decoration: const InputDecoration(
                      labelText: 'Add Remarks',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 30),


                    ),

                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(

                    onPressed: () => {},
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                      backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                      overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: const Text("Split Between"),
                  ),


                ],
              )
          ),
          actions: <Widget>[

            ElevatedButton(
              onPressed: () => {Navigator.of(context).pop()},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Cancel"),
            ),


            ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("ADD"),
            ),
          ],
        );
      });

}