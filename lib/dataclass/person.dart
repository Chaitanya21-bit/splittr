import 'package:flutter/foundation.dart';
import 'package:splitter/dataclass/transactions.dart';

class Person extends ChangeNotifier {
  late String name;
  late String uid;
  late String alias;
  late String email;
  late String phoneNo;
  late List<String> userGroups;
  List<Transactions> userTransactions = [];
  late double limit;

  void fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    alias = json['alias'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    limit = double.parse(json['limit'].toString());
    userGroups = json['userGroups'] != null
        ? List.of(json['userGroups'].cast<String>())
        : [];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'alias': alias,
        'email': email,
        'phoneNo': phoneNo,
        'limit': limit,
        'userGroups': userGroups,
        'userTransactions': List<String>.generate(
            userTransactions.length, (index) => userTransactions[index].tid)
      };

  void addTransaction(Transactions transaction) {
    userTransactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(Transactions transaction) {
    userTransactions.remove(transaction);
    notifyListeners();
  }
}
