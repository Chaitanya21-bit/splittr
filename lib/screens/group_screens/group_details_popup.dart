import 'package:flutter/material.dart';

import '../../dataclass/group.dart';
import '../../dataclass/person.dart';
import 'group_details_dropdown.dart';

Future groupDetails(BuildContext context, Group group) {

  Iterable<Person> P = group.members;   //Makeing iterable of group members then append each name in a string list
  List<String> items = [];
  P.forEach((element) {
    items.add(element.name.toString());
  });
  print(items);

  return showDialog(
      context: context,
      builder: (context) {
            return AlertDialog(
              scrollable: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: const Center(
                child: Text('Group Details'),
              ),
              content: Column(
                  children: [
                    Text(group.groupName.toString()),
                      //List for Members
                      // SizedBox(
                      //   height: 200,
                      //   child: ListView.builder(
                      //       itemCount: 5,
                      //       shrinkWrap: true,
                      //       physics: const BouncingScrollPhysics(),
                      //       scrollDirection: Axis.horizontal,
                      //
                      //       itemBuilder: (BuildContext context, int index) {
                      //         return ListTile(
                      //             leading: const Icon(Icons.list),
                      //             trailing: const Text("GFG",style: TextStyle(color: Colors.green, fontSize: 15),
                      //             ),
                      //             title: Text("List item ${items[index]}"));
                      //       }
                      //   ),
                      // ),
                    Row(
                        children: [
                          Expanded(
                              child: GroupDetailsDropdown(
                                group: group,
                              )
                          )
                        ]
                    ),
                  ],
              ),
            );
          },

      );
}
