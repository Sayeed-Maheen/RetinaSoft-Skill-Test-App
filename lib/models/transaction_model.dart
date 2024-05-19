class Transaction {
  final int id;
  final double amount;
  final String date;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: double.parse(json['amount']),
      date: json['transaction_date'],
    );
  }
}
