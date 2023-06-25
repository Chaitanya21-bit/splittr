import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/user.dart';
import 'package:splitter/utils/toasts.dart';

import '../services/services.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;
  final UserService _userService = UserService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<User?> retrieveUserInfo(String uid) async {
    final prefsUser = await _userService.getUserFromPrefs(uid);
    if (prefsUser != null) {
      _user = prefsUser;
    } else {
      final dbUser = await _userService.getUserFromDatabase(uid);
      if (dbUser != null) {
        _user = dbUser;
      } else {
        await _authService.signOut();
        showToast("You Got Deleted ^_^");
        return null;
      }
    }
    return _user;
  }

  Future<void> addTransaction(String transactionId) async {
    _user.personalTransactions.add(transactionId);
    await updateUser();
  }

  Future<void> deleteTransaction(String transactionId) async {
    _user.personalTransactions.remove(transactionId);
    await updateUser();
  }

  Future<void> addGroup(String groupId) async {
    _user.groups.add(groupId);
    await updateUser();
  }

  Future<void> deleteGroup(String groupId) async {
    _user.groups.remove(groupId);
    await updateUser();
  }

  Future<void> updateUser() async {
    await _userService.updateUserToDatabase(user);
    debugPrint("User Updated");
    notifyListeners();
  }

}
