import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/services/group_service.dart';

import '../utils/get_provider.dart';
import '../utils/toasts.dart';

class GroupProvider extends ChangeNotifier {
  final List<Group> _groups = [];
  late final UserProvider _userProvider;
  final GroupService _groupService = GroupService();

  List<Group> get groups => _groups;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  late int _selectedIndex;

  Group getCurrentGroup() {
    // calcTotal();
    return _groups[_selectedIndex];
  }

  // void calcTotal() {
  //   var sum = _groups[_selectedIndex].transactions.add()
  //   _groups[_selectedIndex].totalAmount = sum;
  // }
  void init(BuildContext context) {
    _userProvider = getProvider<UserProvider>(context,listen: false);
    fetchGroups();
  }

  void setCurrentGroup(int index) {
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
      final group = await _groupService.getGroupFromDatabase(groupId);
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
    if (_groups.where((e) => e.gid == group.gid).isNotEmpty) {
      showToast("Already Joined");
      return;
    }
    group.members.add(User.basicInfo(_userProvider.user.toJson()));

    //Code here to add in Matrix

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
