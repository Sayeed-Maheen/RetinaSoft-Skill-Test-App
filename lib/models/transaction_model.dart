class Transaction {
  final int id;
  final double amount;
  final String transactionDate;
  final String? billNo;
  final String? details;
  final int? status;
  final String? transactionNo;
  final int? type;

  Transaction({
    required this.id,
    required this.amount,
    required this.transactionDate,
    this.billNo,
    this.details,
    this.status,
    this.transactionNo,
    this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionNo: json['transaction_no']?.toString(),
      type: json['type'] is String ? int.parse(json['type']) : json['type'],
      amount: json['amount'] is String
          ? double.parse(json['amount'])
          : json['amount'],
      transactionDate: json['transaction_date'],
      details: json['details'],
      billNo: json['bill_no']?.toString(),
      status:
          json['status'] is String ? int.parse(json['status']) : json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_no': transactionNo,
      'type': type,
      'amount': amount.toString(),
      'transaction_date': transactionDate,
      'details': details,
      'bill_no': billNo,
      'status': status,
    };
  }
}
