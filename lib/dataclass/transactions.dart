import 'package:splitter/dataclass/person.dart';

class Transactions {
  late String tid;
  late String title;
  late double amount;
  late String date;
  late String remarks;
  // late String personId;

  Transactions(
      {
        required this.tid,
      required this.title,
      required this.amount,
      required this.date,
      required this.remarks});

  static Transactions fromJson(Map<String, dynamic> json) {
    return Transactions(
        tid: json['tid'],
        title: json['title'],
        amount: double.parse(json['amount'].toString()),
        date: json['date'],
        remarks: json['remarks']);
  }

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'title': title,
        'amount': amount,
        'date': date,
        'remarks': remarks
      };
}
