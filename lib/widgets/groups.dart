import 'package:flutter/material.dart';

class MyGroups extends StatelessWidget{
  final String child;

  MyGroups({required this.child});
  @override
  Widget build(BuildContext context){
    return Container(
                width: 200,
                margin: EdgeInsets.only(right: 20),
                height: MediaQuery.of(context).size.height * 0.30 - 50,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text(child, style: TextStyle(fontSize: 20))),
                ),
              );
  }
}