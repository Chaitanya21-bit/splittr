import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';

import '../auth/firebase_manager.dart';

final FirebaseAuth auth = FirebaseManager.auth;
final FirebaseDatabase database = FirebaseManager.database;

class Group extends ChangeNotifier{
  late String groupName;
  late String gid;
  late String groupDescription;
  late double? groupLimit;
  List<Person> members = [];
  late List<dynamic> memberColors = [];
  late List<Transactions> transactions = [];
  late Uri link;

  Group(
      {required this.groupName,
      required this.gid,
      required this.groupDescription,
      this.groupLimit = -1,
      required this.link});

  static Future<Group> fromJson(Map<String, dynamic> json) async {
    Group group = Group(
        groupName: json['groupName'],
        gid: json['gid'],
        groupDescription: json['groupDescription'],
        groupLimit: double.parse(json['groupLimit'].toString()),
        link: Uri.parse(json['link']));

    List transactionsList = json['transactions'] ?? [];
    for (var transaction in transactionsList) {
      var snapshot =
          await database.ref().child('Transactions/$transaction').get();
      Map<String, dynamic> map =
      Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      group.transactions.add(await Transactions.fromJson(map));
  }

    return group;
  }

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'gid': gid,
        'groupDescription': groupDescription,
        'groupLimit': groupLimit,
        'members': List<String>.generate(
            members.length, (index) => members[index].uid),
    'transactions': List<String>.generate(
        transactions.length, (index) => transactions[index].tid),
        'link': link.toString()
      };



  Future<void> retrieveMembers(List<String> membersList) async {
    for (var member in membersList) {
      Person person = Person();
      await person.retrieveBasicInfo(member);
      members.add(person);
    }
  }

  Future<void> addTransaction(Transactions transaction,Person person) async {
    print("Group Transaction Created");
    transactions.add(transaction);
    await database
        .ref('Transactions/${transaction.tid}')
        .set(transaction.toJson());
    print("Transaction Stored");
    await database.ref('Users/${person.uid}').update(person.toJson());

    await database.ref('Group/$gid').update(toJson());

    print("User Updated");
    notifyListeners();
  }
}
//Add notify listner