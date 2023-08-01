import 'package:flutter/cupertino.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/services/firebase_database_service.dart';

class PersonalTransactionService {

  Future<void> addTransactionToDatabase(PersonalTransaction transaction) async {
    await FirebaseDatabaseService.set(
        '$transactionsEndpoint${transaction.tid}', transaction.toJson());
    debugPrint("Transaction Updated in Database");
  }

  Future<PersonalTransaction?> getTransactionFromDatabase(String transactionId) async {
    final json =
        await FirebaseDatabaseService.get<PersonalTransaction>("$transactionsEndpoint$transactionId");
    return json == null ? null : PersonalTransaction.fromJson(json);
  }


  Future<void> deleteTransactionFromDatabase(
      PersonalTransaction transaction) async {
    await FirebaseDatabaseService.remove('$transactionsEndpoint${transaction.tid}');
    debugPrint("Transaction deleted from Database");
  }


}
