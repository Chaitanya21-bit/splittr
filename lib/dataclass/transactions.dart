import 'package:intl/intl.dart';

class PersonalTransaction {
  late String tid;
  late String userId;
  late String title;
  late double amount;
  late DateTime date;
  late String remarks;
  late String category;

  PersonalTransaction(
      {required this.tid,
      required this.userId,
      required this.title,
      required this.amount,
      required this.date,
      required this.remarks,
      required this.category});

  factory PersonalTransaction.fromJson(Map<String, dynamic> json) =>
      PersonalTransaction(
          tid: json['tid'],
          userId: json['userId'],
          title: json['title'],
          amount: double.parse(json['amount'].toString()),
          date: DateTime.parse(json['date']),
          remarks: json['remarks'],
          category: json['category']);

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'userId': userId,
        'title': title,
        'amount': amount,
        'date': DateFormat("yyyy-MM-dd hh:mm:ss").format(date),
        'remarks': remarks,
        'category': category,
      };
}
