import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<void> addTransaction(Transactions transaction) async {
    print("Transaction Created");
    userTransactions.add(transaction);
    await database
        .ref('Transactions/${transaction.tid}')
        .set(transaction.toJson());
    print("Transaction Stored");
    await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
    print("User Upated");
    notifyListeners();
  }

  Future<void> deleteTransaction(Transactions transaction) async {
    userTransactions.remove(transaction);
    await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
    await database.ref().child('Transactions/${transaction.tid}').remove();
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
        if (snapshot.exists) {
          Map<String, dynamic> map = Map<String, dynamic>.from(
              snapshot.value as Map<dynamic, dynamic>);
          userTransactions.add(Transactions.fromJson(map));
        } else {
          Fluttertoast.showToast(msg: "Transaction not found: $transaction");
        }
      }
    }
  }

  Future<void> addGroup(Group group) async {
    group.members.add(this);
    print("Group Created");
    await database.ref('Group/${group.gid}').update(group.toJson());
    print("Group Stored");
    userGroups.add(group);
    await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
    print("User Upated");
    notifyListeners();
  }

  Future<void> deleteGroup(Group group) async {
    userGroups.remove(group);
    await database.ref().child('Group/${group.gid}').remove();
    await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
    notifyListeners();
  }

  Future<void> retrieveGroups() async {
    final groupsSnapshot = await database
        .ref()
        .child('Users/${auth.currentUser!.uid}/userGroups')
        .get();

    if (groupsSnapshot.exists) {
      final groupsList = groupsSnapshot.value as List;
      for (var groupId in groupsList) {
        var snapshot = await database.ref().child('Group/$groupId').get();
        if (snapshot.exists) {
          Map<String, dynamic> map = Map<String, dynamic>.from(
              snapshot.value as Map<dynamic, dynamic>);
          Group group = Group.fromJson(map);
          await group.retrieveMembers(List.of(map['members'].cast<String>()));
          userGroups.add(group);
        } else {
          Fluttertoast.showToast(msg: "Group Not Found: $groupId");
        }
      }
    }
  }

  Future<void> retrieveBasicInfo(String uid) async {
    final userSnapshot = await database.ref().child('Users/$uid').get();
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(userSnapshot.value as Map<dynamic, dynamic>);
    fromJson(userMap);
  }
}
