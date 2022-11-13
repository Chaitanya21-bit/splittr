import 'package:flutter/material.dart';

class QuickSplit extends StatefulWidget {
  const QuickSplit({Key? key, required this.nameAmountMap}) : super(key: key);
  final Map nameAmountMap;

  @override
  State<QuickSplit> createState() => _QuickSplitState();
}

class _QuickSplitState extends State<QuickSplit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Quick Split'),
      centerTitle: true,
      backgroundColor: const Color(0xff1870B5),
    ));
  }
}
