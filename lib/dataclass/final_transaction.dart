class SplitTransaction {
  late String sender;
  late String receiver;
  late double amount;

  SplitTransaction(
    this.sender,
    this.receiver,
    this.amount,
  );

  factory SplitTransaction.fromJson(dynamic json) {
    return SplitTransaction(json['sender'] as String,
        json['receiver'] as String, json['amount'] as double);
  }

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'receiver': receiver,
        'amount': amount,
      };
}
