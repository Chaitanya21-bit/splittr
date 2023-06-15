import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/user.dart';

import '../services/services.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;
  final UserService _userService = UserService();

  Future<User?> retrieveUserInfo() async {
    String uid = FirebaseAuthService.auth.currentUser!.uid;
    final prefsUser = await _userService.getUserFromPrefs(uid);
    if (prefsUser != null) {
      _user = prefsUser;
    } else {
      final dbUser = await _userService.getUserFromDatabase(uid);
      if (dbUser != null) {
        _user = dbUser;
      } else {
        return null;
      }
    }
    return _user;
  }

  void signOut() async {
    await _userService.signOut();
  }

  Stream<auth.User?> authStateChanges() {
    return _userService.authStateChanges();
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
