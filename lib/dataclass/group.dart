import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/user.dart' as model;
import 'package:splitter/dataclass/personalTransactions.dart';
import 'package:splitter/services/firebase_database_service.dart';


class Group extends ChangeNotifier{
  late String groupName;
  late String gid;
  late String groupDescription;
  late double? groupLimit;
  List<model.User> members = [];
  late List<dynamic> memberColors = [];
  late List<PersonalTransaction> transactions = [];
  late Uri link;
  late double totalAmount = 0;

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
          await FirebaseDatabaseService.database.ref().child('Transactions/$transaction').get();
      Map<String, dynamic> map =
      Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      group.transactions.add(PersonalTransaction.fromJson(map));
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



  // Future<void> retrieveMembers(List<String> membersList) async {
  //   // for (var member in membersList) {
  //   //   Person person = Person();
  //   //   await person.retrieveBasicInfo(member);
  //   //   members.add(person);
  //   // }
  // }
  //
  // Future<void> addTransaction(PersonalTransaction transaction,User person) async {
  //   print("Group Transaction Created");
  //   transactions.add(transaction);
  //   await database
  //       .ref('Transactions/${transaction.tid}')
  //       .set(transaction.toJson());
  //   print("Transaction Stored");
  //   await database.ref('Users/${person.uid}').update(person.toJson());
  //
  //   await database.ref('Group/$gid').update(toJson());
  //
  //   print("User Updated");
  //   notifyListeners();
  // }
}
//Add notify listner