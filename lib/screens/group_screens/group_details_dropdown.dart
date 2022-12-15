import 'package:flutter/material.dart';

import '../../dataclass/group.dart';
import '../../dataclass/person.dart';

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

  @override
  Widget build(BuildContext context) {
    print(group.groupName);
    String? dropdownValue = group.members[0].toString() ;
    final items = group.members;
    // Dropdown value aur item ka ek same hona chahiye vo nai hora iss liye error aara
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
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {dropdownValue = newValue!;});
                    },
                    value: dropdownValue,
                    items: items.map((Person items) {
                      return DropdownMenuItem<String>(value: items.name, child: Text(items.name));
                    }).toList(),
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
