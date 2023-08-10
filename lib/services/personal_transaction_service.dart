import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/dataclass/dataclass.dart';

class PersonalTransactionService {
  final _personalTransactionRef =
      FirebaseFirestore.instance.collection(personalTransactionsCollection);

  Future<void> addTransactionToDatabase(PersonalTransaction transaction) async {
    await _personalTransactionRef.doc(transaction.tid).set(transaction.toJson());
    debugPrint("Transaction Updated in Database");
  }

  Future<PersonalTransaction?> getTransactionFromDatabase(String transactionId) async {
    final snapshot = await _personalTransactionRef.doc(transactionId).get();
    return snapshot.data() == null ? null : PersonalTransaction.fromJson(snapshot.data()!);
  }
  Future<List<PersonalTransaction>> getTransactionFromIds(List<String> tIds) async {
    final queryResult = await _personalTransactionRef
        .where("tid", whereIn: tIds)
        .get();

    return queryResult.docs.map((json) => PersonalTransaction.fromJson(json.data())).toList();
  }

  Future<void> deleteTransactionFromDatabase(PersonalTransaction transaction) async {
    await _personalTransactionRef.doc(transaction.tid).delete();
    debugPrint("Transaction deleted from Database");
  }
}