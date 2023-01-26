class FinalTransaction {
  late String sender;
  late String receiver;
  late double amount;

  FinalTransaction(
         this.sender,
         this.receiver,
         this.amount
  );

  factory FinalTransaction.fromJson(dynamic json){
    return FinalTransaction(
        json['sender'] as String,
        json['receiver'] as String,
        json['amount'] as double
    );
  }

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'receiver': receiver,
    'amount': amount,
  };

  // static FinalTransaction fromJson(Map<String, dynamic> json) {
  //   return FinalTransaction(
  //       sender: json['sender'],
  //       receiver: json["receiver"],
  //       amount: double.parse(json['amount'].toString())
  //   );
  // }
}