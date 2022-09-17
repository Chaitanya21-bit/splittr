import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// DropdownButton<String> dropdown(){
//   var dropdownValue = 'What For?';
//   return DropdownButton<String>(
//     value: dropdownValue,
//     icon: const Icon(Icons.arrow_downward),
//     iconSize: 24,
//     elevation: 16,
//     style: const TextStyle(
//         color: Colors.deepPurple
//     ),
//     underline: Container(
//       height: 2,
//       color: Colors.deepPurpleAccent,
//     ),
//     onChanged: (String? newValue) {
//       setState(() {
//         dropdownValue = newValue!;
//       });
//     },
//     items: <String>['One', 'Two', 'Free', 'Four']
//         .map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     })
//         .toList(),
//   );
// }

class WhatForDropdown extends StatefulWidget{

  const WhatForDropdown({super.key});



  @override
  MyDropDown createState() => MyDropDown();
}

class MyDropDown extends State<WhatForDropdown>{

  String? dropdownValue = 'Apple';
  @override
  Widget build(BuildContext context) {


    final items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];
    // return Container(
    //     height: 1,
    //     child: DropdownButtonHideUnderline(
    //       child: DropdownButton<String>(
    //         isExpanded: true,
    //         value: dropdownValue,
    //         icon: const Icon(Icons.arrow_downward),
    //       // iconSize: 24,
    //       // elevation: 16,
    //       // style: const TextStyle(
    //       //     color: Colors.deepPurple
    //       // ),
    //       // underline: Container(
    //       //   height: 2,
    //       //   color: Colors.deepPurpleAccent,
    //       // ),
    //           onChanged: (String? newValue) {
    //             setState(() {
    //               dropdownValue = newValue!;
    //             });
    //           },
    //           items: <String>['One', 'Two', 'Free', 'Four']
    //               .map<DropdownMenuItem<String>>((String value) {
    //             return DropdownMenuItem<String>(
    //               value: value,
    //               child: Text(value),
    //             );
    //           }).toList(),
    //         ),
    //         ),
    //
    // );
    return  Container(

      padding: const EdgeInsets.all(10.0),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                height: 40,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                      color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(

                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue){
                      setState(() {
                        this.dropdownValue = newValue!;
                      });
                    },
                    value: dropdownValue,
                    items:items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                    }
                    ).toList(),



                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }



}


