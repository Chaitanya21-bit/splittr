import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/services/firebase_database_service.dart';

class PersonalTransactionService extends ChangeNotifier {
  final List<PersonalTransaction> _personalTransactions = [];
  List<PersonalTransaction> get personalTransactions => _personalTransactions;

  final _database = FirebaseDatabaseService();

  addTransaction(PersonalTransaction transaction, Person person) async {
    _personalTransactions.add(transaction);
    person.personalTransactions.add(transaction.tid);
    debugPrint("Personal Transaction Created");
    await _database.
    set('Transactions/${transaction.tid}',transaction.toJson());
    debugPrint("Transaction Updated in Database");

    await _database.update('Users/${transaction.userId}',person.toJson());
    debugPrint("User Updated");
    notifyListeners();
  }

  Future<void> deleteTransaction(
      PersonalTransaction transaction, Person person) async {
    _personalTransactions.remove(transaction);
    person.personalTransactions.remove(transaction.tid);
    await _database
        .update('Users/${auth.currentUser?.uid}',person.toJson());
    await _database.remove('Transactions/${transaction.tid}');
    notifyListeners();
  }

  fetchTransactions(List<String> transactionsList) async {
    for (String transactionId in transactionsList) {
      final json = await _database.get("Transactions/$transactionId");
      if(json != null){
        _personalTransactions.add(PersonalTransaction.fromJson(json));
        notifyListeners();
      }
    }
    print("Retrieved Transactions");
  }
}
