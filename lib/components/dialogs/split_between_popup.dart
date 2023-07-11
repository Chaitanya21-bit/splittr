///NOT CURRENTLY IN USE ///






// import 'package:flutter/material.dart';
// import 'package:splitter/providers/providers.dart';
// import 'package:splitter/size_config.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../dataclass/dataclass.dart';
// import '../../utils/get_provider.dart';
// import '../cards/set_split_card.dart';
//
// class SplitBetweenDialog {
//
//   //Radio btn not working
//
//   late final BuildContext context;
//   late double amount;
//
//   late final GroupProvider _groupProvider;
//   late final Group _group;
//   late final User _user;
//   int customEditValue = 1;
//
//
//   SplitBetweenDialog(this.context,{required double this.amount}) {
//     _initProviders();
//   }
//
//
//   void _initProviders() {
//     _groupProvider = getProvider<GroupProvider>(context);
//     _group = _groupProvider.getCurrentGroup();
//     _user = getProvider<UserProvider>(context).user;
//   }
//
//   _exit() {
//     Navigator.pop(context);
//   }
//   void _RadioChanged(int? value) {
//     // setState(() {
//     customEditValue = 1;
//     // });
//   }
//   // _createTransaction() async {
//   show() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           scrollable: true,
//           contentPadding: EdgeInsets.zero,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))
//           ),
//           title: const Center(
//             child: Text('Split Between',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           content: Container(
//             height: SizeConfig.screenHeight /1.5,
//             child: Form(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Text(_group.groupName),
//                     ),
//                     Text('${amount.toString()}'),
//                     RadioListTile(
//                       title: Text('Split Evenly'),
//                       value: 0,
//                       groupValue: customEditValue,
//                       onChanged: _RadioChanged,
//                     ),
//                     Divider(
//                       color: Colors.black,
//                       height: 1,
//                     ),
//                     RadioListTile(
//                       title: Text('Custom Split'),
//                       value: 1,
//                       groupValue: customEditValue,
//                       onChanged: _RadioChanged,
//                     ),
//                     //Make this whole as new File stful & pass members, amount to calc split and then call card
//
//                     SizedBox(
//                       height: 300,
//                       width: 300,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: _group.members.length,
//                           itemBuilder: (context, index) {
//                             return SetSplitCard(
//                               memberName: _group.members[index].name.toString(),
//                               amount : amount,
//                               length : _group.members.length,
//                             );
//                           }),
//                     ),
//                     TextButton(onPressed: (){}, child: Text("Fill Rest Evenly")),
//                   ],
//                 )
//             ),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: _exit,
//               style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all(const Color(0xff1870B5)),
//                 overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
//               ),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: _exit,
//               style: ButtonStyle(
//                 backgroundColor:
//                 MaterialStateProperty.all(const Color(0xff1870B5)),
//                 overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
//               ),
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
