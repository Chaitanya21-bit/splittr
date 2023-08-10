import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/services/services.dart';
import 'package:splitter/utils/get_provider.dart';

class PersonalTransactionProvider extends ChangeNotifier {
  final List<PersonalTransaction> _personalTransactions = [];
  final PersonalTransactionService _personalTransactionService = PersonalTransactionService();
  late final UserProvider _userProvider;

  List<PersonalTransaction> get personalTransactions => _personalTransactions;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void init(BuildContext context) {
    _userProvider = getProvider<UserProvider>(context, listen: false);
    fetchTransactions();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void fetchTransactions() async {
    _setLoading(true);
    personalTransactions.addAll(await _personalTransactionService
        .getTransactionFromIds(_userProvider.user.personalTransactions));
    debugPrint("Retrieved Transactions");
    _setLoading(false);
  }

  Future<void> addTransaction(PersonalTransaction transaction) async {
    _personalTransactions.add(transaction);
    debugPrint("Personal Transaction Created");
    await _personalTransactionService.addTransactionToDatabase(transaction);
    await _userProvider.addTransaction(transaction.tid);
    notifyListeners();
  }

  Future<void> deleteTransaction(PersonalTransaction transaction) async {
    _personalTransactions.remove(transaction);
    debugPrint("Personal Transaction Deleted");
    await _personalTransactionService.deleteTransactionFromDatabase(transaction);
    await _userProvider.deleteTransaction(transaction.tid);
    notifyListeners();
  }
}