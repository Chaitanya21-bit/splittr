import 'package:flutter/material.dart';

import '../../dataclass/group.dart';
import '../../dataclass/user.dart';

class GroupDetailsDropdown extends StatefulWidget {

  final Group group;
  const GroupDetailsDropdown({
    Key? key,
    required this.group
  }) : super(key: key);

  @override
  MyDropDown createState() => MyDropDown(group);
}

class MyDropDown extends State<GroupDetailsDropdown> {
  final Group group;
  MyDropDown(this.group);

  String? value;
  @override
  Widget build(BuildContext context) {
    print('Grp Dashboard Dropdown');

    Iterable<User> P = group.members;   //Makeing iterable of group members then append each name in a string list
    List<String> items = [];
    P.forEach((element) {
      items.add(element.name.toString());
    });
    print(items);


    return Container(
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
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (String? newValue) {
                      setState(() {
                        this.value = newValue!;
                      });
                    },
                    value: value,
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                  ),
                ),



                  // child: DropdownButton(
                  //   value: value,
                  // onChanged: (value) => setState(() {
                  //   this.value = value;
                  // }),
                  // items: items.map(buildDD).toList(),
                  // ),
                ),
            ],
          ),
        ],
      ),
    );
  }


}
