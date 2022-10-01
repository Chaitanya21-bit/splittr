import 'package:flutter/material.dart';

class MyMoneyUsed extends StatelessWidget{
  final String child;

  MyMoneyUsed({required this.child});
  @override
  Widget build(BuildContext context){
    return Container(
                width: 430,
                margin: EdgeInsets.only(right: 20),
                height: 100,
                decoration: BoxDecoration(
                              color: Colors.lightBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                  color: Colors.blue, width: 3),
                            ),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(child: Text(child, style: TextStyle(fontSize: 20))),
                ),
              );
  }
}