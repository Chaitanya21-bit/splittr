import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/group_transaction.dart';
import 'package:splitter/dataclass/user.dart';

class Group extends ChangeNotifier {
  late String groupName;
  late String gid;
  late String groupDescription;
  late double? groupLimit;
  late List<User> members;
  late List<GroupTransaction> transactions;
  late Uri link;
  late double totalAmount;

  Group(
      {required this.groupName,
      required this.gid,
      required this.groupDescription,
      required this.groupLimit,
      required this.link,
      required this.totalAmount,
      this.members = const [],
      this.transactions = const []});

  static Group fromJson(Map<String, dynamic> json) => Group(
      groupName: json['groupName'],
      gid: json['gid'],
      groupDescription: json['groupDescription'],
      groupLimit: double.parse(json['groupLimit'].toString()),
      link: Uri.parse(json['link']),
      totalAmount: double.parse(json['totalAmount'].toString()));

  // List transactionsList = json['transactions'] ?? [];
  // for (var transaction in transactionsList) {
  // var snapshot = await FirebaseDatabaseService.database
  //     .ref()
  //     .child('Transactions/$transaction')
  //     .get();
  // Map<String, dynamic> map =
  // Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
  // group.transactions.add(PersonalTransaction.fromJson(map));
  // }
  //
  // return group;

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'gid': gid,
        'groupDescription': groupDescription,
        'groupLimit': groupLimit,
        'members': List<String>.generate(
            members.length, (index) => members[index].uid),
        'transactions': List<String>.generate(
            transactions.length, (index) => transactions[index].tid),
        'link': link.toString(),
        'totalAmount': totalAmount,
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
