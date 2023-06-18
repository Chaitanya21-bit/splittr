import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/user.dart';

import '../services/services.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;
  final UserService _userService = UserService();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  Future<User?> retrieveUserInfo() async {
    String uid = _firebaseAuthService.auth.currentUser!.uid;
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

  // void signOut() async {
  //   await _firebaseAuthService.signOut();
  // }
  //
  // Stream<auth.User?> authStateChanges() {
  //   return _firebaseAuthService.authStateChanges();
  // }

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
