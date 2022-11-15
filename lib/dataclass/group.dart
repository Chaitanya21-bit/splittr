import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';

import '../auth/firebase_manager.dart';

final FirebaseAuth auth = FirebaseManager.auth;
final FirebaseDatabase database = FirebaseManager.database;

class Group {
  late String groupName;
  late String gid;
  late String groupCode;
  late String groupDescription;
  late double? groupLimit;
  List<Person> members = [];
  late List<dynamic> memberColors = [];
  late List<Transactions> transactions = [];

  Group(
      {required this.groupName,
      required this.gid,
      required this.groupCode,
      required this.groupDescription,
      this.groupLimit = -1});

  static Group fromJson(Map<String, dynamic> json) {
    return Group(
        groupName: json['groupName'],
        gid: json['gid'],
        groupCode: json['groupCode'],
        groupDescription: json['groupDescription'],
        groupLimit: double.parse(json['groupLimit'].toString()));
  }

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'gid': gid,
        'groupCode': groupCode,
        'groupDescription': groupDescription,
        'groupLimit': groupLimit,
        'members':
            List<String>.generate(members.length, (index) => members[index].uid)
      };

  Future<void> retrieveTransactions() async {
    final transactionsSnapshot = await database
        .ref()
        .child('Users/${auth.currentUser!.uid}/userTransactions')
        .get();
    if (transactionsSnapshot.exists) {
      final transactionsList = transactionsSnapshot.value as List;
      for (var transaction in transactionsList) {
        var snapshot =
            await database.ref().child('Transactions/$transaction').get();
        Map<String, dynamic> map =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        transactions.add(Transactions.fromJson(map));
      }
    }
  }

  Future<void> retrieveMembers(List<String> membersList) async {
    for (var member in membersList) {
      Person person = Person();
      await person.retrieveBasicInfo(member);
      members.add(person);
    }
  }
}
