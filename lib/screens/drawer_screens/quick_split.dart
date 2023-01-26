import 'package:flutter/material.dart';
import 'package:splitter/dataclass/final_transaction.dart';
import 'dart:convert';

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
  List<Map> senderReceiver = [];
  double total = 0;
  late double individualShare;
  late List<double> individualShareList;

  //for storing the sender receiver and amount of final transaction in the form of class instance(objects)
  List<FinalTransaction> tags = [];

  // will be storing the json object after jsonEncode() function has been used
  late String jsonTags;

  @override
  void initState() {

    // FinalTransaction finaltransaction = FinalTransaction('bezkoder', 'adfaafadf', 34);
    // String jsonUser = jsonEncode(finaltransaction);
    // print('here is the json object');
    // print(jsonUser);


    // String jsonTags = jsonEncode(tags);
    // print(jsonTags);

    people = widget.people;
    people.sort((a, b) => a['amount'].compareTo(b['amount']));
    for (var person in people) {
      total += person['amount'];
      // print(person['name']);
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
        // finalTransaction ke object mei second person first person ko dega to +ve amount
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|${individualShareList[i]}"
        });

        // sending the sender, receiver and amount to final_transaction dataclass to form jason object using jsonEncode()
        tags.add(FinalTransaction(people[i]['name'], people[j]['name'], individualShareList[i]));
        jsonTags = jsonEncode(tags);
        print(jsonTags);

        individualShareList[i] = 0;
        individualShareList[j] = sum;
        i++;
      } else if (sum < 0) {
        // finalTransaction ke object mei first person second ko dega to -ve amount
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|-${individualShareList[j]}"
        });

        // sending the sender, receiver and amount to final_transaction dataclass to form jason object using jsonEncode()
        tags.add(FinalTransaction(people[i]['name'], people[j]['name'], -individualShareList[j]));
        jsonTags = jsonEncode(tags);
        print(jsonTags);

        individualShareList[j] = 0;
        individualShareList[i] = sum;
        j--;
      } else {
        finalTransaction.add({
          people[i]['name']: "${people[j]['name']}|${individualShareList[i]}"
        });

        // sending the sender, receiver and amount to final_transaction dataclass to form jason object using jsonEncode()
        tags.add(FinalTransaction(people[i]['name'], people[j]['name'], individualShareList[i]));
        jsonTags = jsonEncode(tags);
        print(jsonTags);

        individualShareList[j] = 0;
        individualShareList[i] = 0;
        i++;
        j--;
      }
    }

    print(finalTransaction);
    super.initState();
  }

  // parseJsonFunction(){
  //
  //   print("sender = ${parsedJson['sender']}");
  //   print("${parsedJson['sender']} has to pay ${parsedJson['amount']} to ${parsedJson['receiver']}");
  //   return(Text('${parsedJson['sender']} has to pay ${parsedJson['amount']} to ${parsedJson['receiver']}'));
  // }

  @override
  Widget build(BuildContext context) {


    final jsonData = jsonTags;
    // final parsedJson = jsonDecode(jsonData);

    // converting json object back to class object so that the data can be individually accessed and the traversing can be performed in the list
    var tagObjsJson = jsonDecode(jsonData) as List;

    // List<FinalTransaction> tagObjs = tagObjsJson.map((tagJson) => FinalTransaction.fromJson(tagJson)).toList();
    // print(tagObjs);
    // return(Text('${parsedJson['sender']} has to pay ${parsedJson['amount']} to ${parsedJson['receiver']}'));

    return Scaffold(
      appBar: AppBar(
          title: const Text('Quick Split'),
          centerTitle: true,
          backgroundColor: const Color(0xff1870B5)),
      body: ListView.builder(
          itemCount: finalTransaction.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                   // child: Text(finalTransaction[index].toString()),
                // child: Text('${parsedJson[index].sender} has to pay ${parsedJson[index].amount} to ${parsedJson[index].receiver}')
                //   child: Text(parsedJson.toString())
                  child: (tagObjsJson[index]['amount']>0)?
                  Text('${tagObjsJson[index]['receiver']} has to pay Rs. ${tagObjsJson[index]['amount']} to ${tagObjsJson[index]['sender']}'):
                  Text('${tagObjsJson[index]['sender']} has to pay Rs. ${-tagObjsJson[index]['amount']} to ${tagObjsJson[index]['receiver']}')
              )
            );
          }),
    );
  }
}
