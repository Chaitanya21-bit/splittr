import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';

class GroupService {
  final _groupRef = FirebaseFirestore.instance.collection(groupsCollection);
  final _userRef = FirebaseFirestore.instance.collection(usersCollection);
  final _groupTransactionRef = FirebaseFirestore.instance.collection(groupTransactionsCollection);

  Future<void> createGroupInDatabase(Group group) async {
    await _groupRef.doc(group.gid).set(group.toJson());
    debugPrint("Group Added in Database");
  }

  Future<void> updateGroup(Group group) async {
    await _groupRef.doc(group.gid).update(group.toJson());
    debugPrint("Group Updated in Database");
  }

  Future<void> addGroupTransaction(Group group, GroupTransaction groupTransaction) async {
    await updateGroup(group);
    await _groupTransactionRef.doc(groupTransaction.tid).set(groupTransaction.toJson());
    debugPrint("Added Group Transaction");
  }

  Future<Group?> getGroupFromDatabase(String groupId) async {
    final snapshot = await _groupRef.doc(groupId).get();
    final json = snapshot.data();
    if (json == null) {
      return null;
    }
    if (json['transactions'] != null) {
      json['transactions'] = await getGroupTransactionsJson(
          (json['transactions'] as List).map((e) => e.toString()).toList());
    }
    if (json['members'] != null) {
      json['members'] =
          await getMembersJson((json['members'] as List).map((e) => e.toString()).toList());
    }

    return Group.fromJson(json);
  }

  Future<List<Group>> getGroupFromIds(List<String> iDs) async {
    final List<Map<String, dynamic>> groupsJson = [];
    final querySnapshot = await _groupRef.where("gid",whereIn: iDs).get();
    for (var o in querySnapshot.docs) {
      final midJson = o.data();

      final membersQuery = await _userRef.where('uid',whereIn: o.data()['members']).get();
      midJson['members'] = membersQuery.docs.map((e) => e.data()).toList();

      if(o.data()['transactions'].isNotEmpty){
        final transactionQuery = await _userRef.where('tid',whereIn: o.data()['transactions']).get();
        midJson['transactions'] = transactionQuery.docs.map((e) => e.data()).toList();
      }
      groupsJson.add(midJson);
    }
    return groupsJson.map((json) => Group.fromJson(json)).toList();
  }

  Future<List<Map<String, dynamic>>> getGroupTransactionsJson(List<String> transactionsId) async {
    final List<Map<String, dynamic>> transactionsJson = [];
    for (String transactionId in transactionsId) {
      final snapshot = await _groupTransactionRef.doc(transactionId).get();
      final json = snapshot.data();
      if (json != null) transactionsJson.add(json);
    }
    return transactionsJson;
  }

  Future<List<Map<String, dynamic>>> getMembersJson(List<String> membersId) async {
    final List<Map<String, dynamic>> members = [];
    for (String memberId in membersId) {
      final snapshot = await _userRef.doc(memberId).get();
      final json = snapshot.data();
      if (json != null) members.add(json);
    }
    return members;
  }
}