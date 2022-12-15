class GroupTransactions {
  late String tid;
  late String title;
  late double amount;
  late String date;
  late String remarks;
  // late String personId;

  GroupTransactions(
      {
        required this.tid,
        required this.title,
        required this.amount,
        required this.date,
        required this.remarks
      });

  static GroupTransactions fromJson(Map<String, dynamic> json) {
    return GroupTransactions(
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
