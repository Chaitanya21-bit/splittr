import 'package:flutter/foundation.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/services/firebase_database_service.dart';

class GroupService extends ChangeNotifier{
  final List<Group> _groups = [];
  List<Group> get groups => _groups;

  late int _selectedIndex;
  Group getCurrentGroup() => _groups[_selectedIndex];

  setCurrentGroup(int index){
    _selectedIndex = index;
  }

  Future<void> addGroup(Group group, User user) async {
    _groups.add(group);
    user.groups.add(group.gid);
    debugPrint("Group Created");
    await FirebaseDatabaseService.set(
        '$groupsEndpoint${group.gid}', group.toJson());
    debugPrint("Group Added in Database");

    await FirebaseDatabaseService.update(
        '$usersEndpoint${user.uid}', user.toJson());
    debugPrint("User Updated");
    notifyListeners();
  }

  Future<void> fetchGroups(List<String> groupsList) async {
    for(String groupId in groupsList){
      final json = await FirebaseDatabaseService.get("$groupsEndpoint$groupId");
      if(json == null){
        continue;
      }
      final group = Group.fromJson(json);
      group.members = await fetchMembers(List<String>.from(json['members']));
      group.transactions = await fetchGroupTransactions(json['transactions'] ?? []);
      _groups.add(group);
    }
    debugPrint("Retrieved Groups");
    notifyListeners();
  }

  Future<List<GroupTransaction>> fetchGroupTransactions(List<String> transactionsList) async {
    final List<GroupTransaction> transactions = [];
    for (String transactionId in transactionsList) {
      final json =
          await FirebaseDatabaseService.get("$transactionsEndpoint$transactionId");
      if (json != null) {
        transactions.add(GroupTransaction.fromJson(json));
      }
    }
    return transactions;
  }

  Future<List<User>> fetchMembers(List<String> membersList) async {
    final List<User> members = [];
    for(String memberId in membersList){
      final json = await FirebaseDatabaseService.get("Users/$memberId");
      if(json != null) members.add(User.basicInfo(json));
    }
    return members;
  }
}