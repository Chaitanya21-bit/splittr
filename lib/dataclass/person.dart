import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/group.dart';
import 'package:splitter/dataclass/transactions.dart';

import '../auth/firebase_manager.dart';

final FirebaseAuth auth = FirebaseManager.auth;
final FirebaseDatabase database = FirebaseManager.database;

class Person extends ChangeNotifier {
  late String name;
  late String uid;
  late String alias;
  late String email;
  late String phoneNo;
  List<Group> userGroups = [];
  List<Transactions> userTransactions = [];
  late double limit;

  void fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    alias = json['alias'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    limit = double.parse(json['limit'].toString());
    // userGroups = json['userGroups'] != null
    //     ? List.of(json['userGroups'].cast<String>())
    //     : [];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'alias': alias,
        'email': email,
        'phoneNo': phoneNo,
        'limit': limit,
        'userGroups': List<String>.generate(
            userGroups.length, (index) => userGroups[index].gid),
        'userTransactions': List<String>.generate(
            userTransactions.length, (index) => userTransactions[index].tid)
      };

  void addTransaction(Transactions transaction) {
    userTransactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(Transactions transaction) {
    userTransactions.remove(transaction);
    notifyListeners();
  }

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
        userTransactions.add(Transactions.fromJson(map));
      }
    }
  }

  Future<void> retrieveGroups() async {
    final groupsSnapshot = await database
        .ref()
        .child('Users/${auth.currentUser!.uid}/userGroups')
        .get();

    if (groupsSnapshot.exists) {
      final groupsList = groupsSnapshot.value as List;
      for (var group in groupsList) {
        var snapshot = await database.ref().child('Group/$group').get();
        Map<String, dynamic> map =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        Group groupO = Group.fromJson(map);
        await groupO.retrieveMembers(List.of(map['members'].cast<String>()));
        userGroups.add(groupO);
      }
    }
  }

  Future<void> retrieveBasicInfo(String uid) async {
    final FirebaseDatabase database = FirebaseManager.database;
    final userSnapshot = await database.ref().child('Users/$uid').get();
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(userSnapshot.value as Map<dynamic, dynamic>);
    fromJson(userMap);
  }
}
