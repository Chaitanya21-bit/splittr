import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/user.dart';

import 'firebase_auth_service.dart';
import 'firebase_database_service.dart';

class UserService {
  Future<User?> getUserFromPrefs(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('userMap');

    if (json == null) return null;

    debugPrint("Retrieving User Info from cache");
    final userJson = jsonDecode(json) as Map<String, dynamic>;
    userJson['uid'] = uid;
    await FirebaseDatabaseService.set("$usersEndpoint$uid", userJson);
    await prefs.remove('userMap');
    return User.fromJson(userJson);
  }

  Future<User?> getUserFromDatabase(String uid) async {
    final json = await FirebaseDatabaseService.get<User>("$usersEndpoint$uid");
    if (json == null) return null;

    debugPrint("Retrieving User Info from database");
    return User.fromJson(json);
  }

  Future<void> signOut() async {
    return FirebaseAuthService.signOut();
  }

  Stream<auth.User?> authStateChanges() {
    return FirebaseAuthService.auth.authStateChanges();
  }

  updateUserToDatabase(User user) async {
    await FirebaseDatabaseService.update(usersEndpoint+user.uid, user.toJson());
  }
}
