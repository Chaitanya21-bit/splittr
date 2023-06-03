import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  late String name;
  late String uid;
  late String alias;
  late String email;
  late String phoneNo;
  late List<String> groups;
  late List<String> personalTransactions;
  double limit = -1;

  User({
    required this.uid,
    required this.name,
    required this.alias,
    required this.email,
    required this.phoneNo,
    required this.groups,
    required this.personalTransactions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        name: json['name'],
        alias: json['alias'],
        email: json['email'],
        phoneNo: json['phoneNo'],
        groups: json['groups'] == null ? [] : List<String>.from(json['groups']),
        personalTransactions: json['personalTransactions'] == null ? [] : List<String>.from(json['personalTransactions']));
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'alias': alias,
        'email': email,
        'phoneNo': phoneNo,
        'limit': limit,
        'groups': groups,
        'personalTransactions': personalTransactions
      };

  // Future<void> retrieveTransactions() async {
  //   final transactionsSnapshot = await database
  //       .ref()
  //       .child('Users/${auth.currentUser!.uid}/userTransactions')
  //       .get();
  //   if (transactionsSnapshot.exists) {
  //     final transactionsList = transactionsSnapshot.value as List;
  //     for (var transaction in transactionsList) {
  //       var snapshot =
  //           await database.ref().child('Transactions/$transaction').get();
  //       if (snapshot.exists) {
  //         Map<String, dynamic> map = Map<String, dynamic>.from(
  //             snapshot.value as Map<dynamic, dynamic>);
  //         print(map);
  //         personalTransactions.add(await PersonalTransaction.fromJson(map));
  //       } else {
  //         Fluttertoast.showToast(msg: "Transaction not found: $transaction");
  //       }
  //     }
  //     print("Retrieved Transactions");
  //   }
  // }
  //
  // Future<void> addGroup(Group group) async {
  //   group.members.add(this);
  //   print("Group Created");
  //   await database.ref('Group/${group.gid}').update(group.toJson());
  //   print("Group Stored");
  //   groups.add(group);
  //   await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
  //   print("User Upated");
  //   notifyListeners();
  // }
  //
  // Future<void> deleteGroup(Group group) async {
  //   groups.remove(group);
  //   await database.ref().child('Group/${group.gid}').remove();
  //   await database.ref('Users/${auth.currentUser?.uid}').update(toJson());
  //   notifyListeners();
  // }
  //
  // Future<void> retrieveGroups() async {
  //   final groupsSnapshot = await database
  //       .ref()
  //       .child('Users/${auth.currentUser!.uid}/userGroups')
  //       .get();
  //
  //   if (groupsSnapshot.exists) {
  //     final groupsList = groupsSnapshot.value as List;
  //     for (var groupId in groupsList) {
  //       var snapshot = await database.ref().child('Group/$groupId').get();
  //       if (snapshot.exists) {
  //         Map<String, dynamic> map = Map<String, dynamic>.from(
  //             snapshot.value as Map<dynamic, dynamic>);
  //         Group group = await Group.fromJson(map);
  //         await group.retrieveMembers(List.of(map['members'].cast<String>()));
  //         groups.add(group);
  //       } else {
  //         Fluttertoast.showToast(msg: "Group Not Found: $groupId");
  //       }
  //     }
  //     print("Retrieved Groups");
  //   }
  //   // notifyListeners();
  // }
}
