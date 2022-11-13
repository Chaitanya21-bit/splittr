import 'package:flutter/material.dart';

class QuickSplit extends StatefulWidget {
  const QuickSplit({Key? key, required this.people}) : super(key: key);
  final List<Map> people;

  @override
  State<QuickSplit> createState() => _QuickSplitState();
}

class _QuickSplitState extends State<QuickSplit> {
  @override
  QuickSplit get widget => super.widget;

  @override
  void initState() {
    super.initState();
  }

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
