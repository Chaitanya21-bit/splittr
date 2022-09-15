class Transactions {
  late String tid;
  late String title;
  late double amount;
  late DateTime date;
  late String expenseOrIncome;
  late String remarks;

  Transactions(
      {required this.tid,
      required this.title,
      required this.amount,
      required this.date,
      required this.expenseOrIncome,
      required this.remarks});

  static Transactions fromJson(Map<String, dynamic> json) {
    return Transactions(
        title: json['title'],
        tid: json['tid'],
        amount: json['amount'],
        date: json['date'],
        expenseOrIncome: json['expenseOrIncome'],
        remarks: json['remarks']);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'tid': tid,
        'amount': amount,
        'date': date,
        'expenseOrIncome': expenseOrIncome,
        'remarks': remarks
      };
}
