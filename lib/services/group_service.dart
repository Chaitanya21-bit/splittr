import 'package:flutter/foundation.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/services/firebase_database_service.dart';

class GroupService {
  Future<void> addGroupToDatabase(Group group) async {
    await FirebaseDatabaseService.set(
        '$groupsEndpoint${group.gid}', group.toJson());
    debugPrint("Group Added in Database");
  }

  Future<Group?> getGroupFromDatabase(String groupId) async {
    final json = await FirebaseDatabaseService.get<Group>("$groupsEndpoint$groupId");
    if (json == null) {
      return null;
    }
    if (json['transactions'] != null) {
      json['transactions'] =
          await getGroupTransactionsJson((json['transactions'] as List).map((e) => e.toString()).toList());
    }
    if (json['members'] != null) {
      json['members'] =
          await getMembersJson((json['members'] as List).map((e) => e.toString()).toList());
    }
    return Group.fromJson(json);
  }

  Future<List<Map<String, dynamic>>> getGroupTransactionsJson(
      List<String> transactionsId) async {
    final List<Map<String, dynamic>> transactionsJson = [];
    for (String transactionId in transactionsId) {
      final json = await FirebaseDatabaseService.get<GroupTransaction>(
          "$transactionsEndpoint$transactionId");
      if (json != null) transactionsJson.add(json);
    }
    return transactionsJson;
  }

  Future<List<Map<String, dynamic>>> getMembersJson(
      List<String> membersId) async {
    final List<Map<String, dynamic>> members = [];
    for (String memberId in membersId) {
      final json = await FirebaseDatabaseService.get<User>("$usersEndpoint$memberId");
      if (json != null) members.add(json);
    }
    return members;
  }
}
