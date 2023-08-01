import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';

import 'firebase_database_service.dart';

class UserService {
  Future<User?> saveUserToDatabase(User user) async {
    await FirebaseDatabaseService.set("$usersEndpoint${user.uid}", user.toJson());
    return user;
  }

  Future<User?> getUserFromDatabase(String uid) async {
    final json = await FirebaseDatabaseService.get<User>("$usersEndpoint$uid");
    if (json == null) return null;

    debugPrint("Retrieving User Info from database");
    return User.fromJson(json);
  }

  updateUserToDatabase(User user) async {
    await FirebaseDatabaseService.update(
        usersEndpoint + user.uid, user.toJson());
  }
}
