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
  late List<Map> people;
  List<Map> finalTransaction = [];
  double total = 0;
  late double individualShare;
  late List<double> individualShareList;

  @override
  void initState() {
    people = widget.people;
    people.sort((a, b) => a['amount'].compareTo(b['amount']));
    for (var person in people) {
      total += person['amount'];
      print(person['name']);
    }
    individualShare = total / people.length;
    individualShareList = List<double>.generate(
        people.length, (index) => people[index]['amount'] - individualShare);
    print(individualShare);
    print(individualShareList);
    int i = 0, j = people.length - 1;

    while (i < j) {
      double sum = individualShareList[i] + individualShareList[j];
      if (sum > 0) {
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|${individualShareList[i]}"
        });
        individualShareList[i] = 0;
        individualShareList[j] = sum;
        i++;
      } else if (sum < 0) {
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|-${individualShareList[j]}"
        });
        individualShareList[j] = 0;
        individualShareList[i] = sum;
        j--;
      } else {
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|${individualShareList[i]}"
        });
        individualShareList[j] = 0;
        individualShareList[i] = 0;
        i++;
        j--;
      }
    }

    print(finalTransaction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Quick Split'),
          centerTitle: true,
          backgroundColor: const Color(0xff1870B5)),
      body: ListView.builder(
          itemCount: finalTransaction.length,
          itemBuilder: (context, index) {
            return Card(
              child: Text(finalTransaction[index].toString()),
            );
          }),
    );
  }
}
