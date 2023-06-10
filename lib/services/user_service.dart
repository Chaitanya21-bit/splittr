import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter/dataclass/user.dart';
import 'firebase_auth_service.dart';
import 'firebase_database_service.dart';

class UserService extends ChangeNotifier{
  late User _user;
  User get user => _user;

  Future<User?> retrieveUserInfo(String uid)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userMap = prefs.getString('userMap');
    if(userMap != null){
      debugPrint("Retrieving User Info from cache");
      final userJson = jsonDecode(userMap) as Map<String, dynamic>;
      userJson['uid'] = uid;
      await prefs.remove('userMap');
      _user = User.fromJson(userJson);
      await FirebaseDatabaseService.set("Users/$uid", userJson);
      return _user;
    }
    final json = await FirebaseDatabaseService.get("Users/$uid");
    if (json == null) {
      await FirebaseAuthService.signOut();
      return null;
    }
    debugPrint("Retrieving User Info from database");
    _user = User.fromJson(json);
    return _user;
  }
}