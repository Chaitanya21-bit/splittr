import 'package:intl/intl.dart';

class GroupTransaction {
  late String tid;
  late String creatorId;
  late String title;
  late double amount;
  late DateTime date;
  late String remarks;
  late String category;
  late List<String> splitBetween;

  GroupTransaction(
      {required this.tid,
      required this.creatorId,
      required this.title,
      required this.amount,
      required this.date,
      required this.remarks,
      required this.category,
      required this.splitBetween});

  factory GroupTransaction.fromJson(Map<String, dynamic> json) =>
      GroupTransaction(
          tid: json["tid"],
          creatorId: json["creatorId"],
          title: json["title"],
          amount: double.parse(json["amount"]),
          date: DateTime.parse(json['date']),
          remarks: json["remarks"],
          category: json["category"],
          splitBetween: List<String>.from(json['splitBetween']));


  Map<String, dynamic> toJson() => {
    "tid" : tid,
    "creatorId" : creatorId,
    "title" : title,
    "amount" : amount,
    "date" : DateFormat("yyyy-MM-dd hh:mm:ss").format(date),
    "remarks" : remarks,
    "category" : category,
    "splitBetween": splitBetween
  };
}
