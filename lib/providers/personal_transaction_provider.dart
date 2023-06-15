import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/personalTransactions.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/services/services.dart';

class PersonalTransactionProvider extends ChangeNotifier {
  final List<PersonalTransaction> _personalTransactions = [];
  final PersonalTransactionService _personalTransactionService =
      PersonalTransactionService();
  final UserProvider _userProvider;

  List<PersonalTransaction> get personalTransactions => _personalTransactions;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  PersonalTransactionProvider(this._userProvider);

  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  fetchTransactions() async {
    _setLoading(true);
    for (String transactionId in _userProvider.user.personalTransactions) {
      final personalTransaction = await _personalTransactionService
          .getTransactionFromDatabase(transactionId);
      if (personalTransaction != null) {
        _personalTransactions.add(personalTransaction);
      }
    }
    debugPrint("Retrieved Transactions");
    _setLoading(false);
  }

  addTransaction(PersonalTransaction transaction) async {
    _personalTransactions.add(transaction);
    debugPrint("Personal Transaction Created");
    await _personalTransactionService.addTransactionToDatabase(transaction);
    await _userProvider.addTransaction(transaction.tid);
    notifyListeners();
  }

  Future<void> deleteTransaction(PersonalTransaction transaction) async {
    _personalTransactions.remove(transaction);
    debugPrint("Personal Transaction Deleted");
    await _personalTransactionService
        .deleteTransactionFromDatabase(transaction);
    await _userProvider.deleteTransaction(transaction.tid);
    notifyListeners();
  }
}
