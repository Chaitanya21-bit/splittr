import 'package:flutter/material.dart';

class GroupItem extends StatelessWidget {
  GroupItem({required this.txt});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 20),
      height: MediaQuery.of(context).size.height * 0.30 - 50,
      decoration: BoxDecoration(
          color: Colors.tealAccent,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(child: Text(txt, style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
