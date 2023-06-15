import 'package:flutter/foundation.dart';
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

  Future<void> addGroup(Group group) async {
    _groups.add(group);
    await _groupService.addGroupToDatabase(group);
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

}