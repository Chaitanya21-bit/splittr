import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/personalTransactions.dart';
import 'package:splitter/dataclass/user.dart';
import 'package:splitter/services/firebase_auth_service.dart';
import 'package:splitter/services/firebase_database_service.dart';

class PersonalTransactionService extends ChangeNotifier {
  final List<PersonalTransaction> _personalTransactions = [];

  List<PersonalTransaction> get personalTransactions => _personalTransactions;

  addTransaction(PersonalTransaction transaction, User user) async {
    _personalTransactions.add(transaction);
    user.personalTransactions.add(transaction.tid);
    debugPrint("Personal Transaction Created");
    await FirebaseDatabaseService.set(
        'Transactions/${transaction.tid}', transaction.toJson());
    debugPrint("Transaction Updated in Database");

    await FirebaseDatabaseService.update(
        'Users/${transaction.userId}', user.toJson());
    debugPrint("User Updated");
    notifyListeners();
  }

  Future<void> deleteTransaction(
      PersonalTransaction transaction, User person) async {
    _personalTransactions.remove(transaction);
    person.personalTransactions.remove(transaction.tid);
    await FirebaseDatabaseService.update(
        'Users/${FirebaseAuthService.auth.currentUser?.uid}', person.toJson());
    await FirebaseDatabaseService.remove('Transactions/${transaction.tid}');
    notifyListeners();
  }

  fetchTransactions(List<String> transactionsList) async {
    for (String transactionId in transactionsList) {
      final json =
          await FirebaseDatabaseService.get("Transactions/$transactionId");
      if (json != null) {
        _personalTransactions.add(PersonalTransaction.fromJson(json));
      }
    }
    debugPrint("Retrieved Transactions");
    notifyListeners();
  }
}
