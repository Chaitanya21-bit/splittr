import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/services/group_service.dart';

class GroupProvider extends ChangeNotifier{
  final List<Group> _groups = [];
  final UserProvider _userProvider;
  final GroupService _groupService = GroupService();
  List<Group> get groups => _groups;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  late int _selectedIndex;
  Group getCurrentGroup() => _groups[_selectedIndex];

  GroupProvider(this._userProvider);

  void setCurrentGroup(int index){
    _selectedIndex = index;
  }

  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> createGroup(Group group) async {
    _groups.add(group);
    await _groupService.createGroupInDatabase(group);
    await _userProvider.addGroup(group.gid);
    notifyListeners();
  }

  Future<void> fetchGroups() async {
    _setLoading(true);
    for (String groupId in _userProvider.user.groups) {
      final group = await _groupService
          .getGroupFromDatabase(groupId);
      if (group != null) {
        _groups.add(group);
      }
    }
    debugPrint("Retrieved Groups");
    _setLoading(false);
  }

  Future<void> updateGroup(Group group) async {
    await _groupService.updateGroup(group);
    notifyListeners();
  }

  Future<void> joinGroup(Group group) async {
    if(_groups.where((e) => e.gid == group.gid).isNotEmpty){
      Fluttertoast.showToast(msg: "Already Joined");
      return;
    }
    group.members.add(User.basicInfo(_userProvider.user.toJson()));
    _groups.add(group);
    await _userProvider.addGroup(group.gid);
    await updateGroup(group);
  }


  Future<void> addGroupTransaction(GroupTransaction groupTransaction) async {
    final group = getCurrentGroup();
    group.transactions.add(groupTransaction);
    await _groupService.addGroupTransaction(group, groupTransaction);
    notifyListeners();
  }
}