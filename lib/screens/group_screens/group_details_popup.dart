import 'package:flutter/material.dart';

import '../../dataclass/group.dart';
import '../../dataclass/user.dart';
import '../../providers/group_provider.dart';
import '../../utils/get_provider.dart';
import 'group_details_dropdown.dart';

Future groupDetails(BuildContext context, Group group) {

  Iterable<User> P = group.members;   //Makeing iterable of group members then append each name in a string list
  List<String> items = [];
  P.forEach((element) {
    items.add(element.name.toString());
  });

  late final GroupProvider _groupProvider;
  late final Group _group;
  _groupProvider = getProvider<GroupProvider>(context);
  _group = _groupProvider.getCurrentGroup();

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
                    Text("Members"),
                      //List for Members
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: ListView.builder(
                            itemCount: _group.members.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),

                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: Text(_group.members[index].name.toString()));
                            }
                        ),
                      ),
                    // Row(
                    //     children: [
                    //       Expanded(
                    //           child: GroupDetailsDropdown(
                    //             group: group,
                    //           )
                    //       )
                    //     ]
                    // ),
                  ],
              ),
            );
          },

      );
}
