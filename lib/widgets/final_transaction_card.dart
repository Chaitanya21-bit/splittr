import 'package:flutter/material.dart';

class FinalTransactionCard extends StatefulWidget {
  final Widget child;

  const FinalTransactionCard({Key? key, required this.child}) : super(key: key);

  @override
  State<FinalTransactionCard> createState() => _FinalTransactionCardState();
}

class _FinalTransactionCardState extends State<FinalTransactionCard> {
  // @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }

    @override
Widget build(BuildContext context){
  return Card(
    margin: const EdgeInsets.all(20.0),
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.all(20.0), 
      child: widget.child,
      decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black, width: 2),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          offset: Offset(10.0, 10.0)
        )
      ]
    )
  ));
  }
}

