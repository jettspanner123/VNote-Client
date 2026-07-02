class TransactionMockModel {
  final String transactionId;
  final String userId;
  final String secondaryUserPhoneNumber;
  final double amount;
  final String? note;
  final TransactionMockDirection transactionDirection;
  final TransactionMockType transactionType;
  final TransactionMockStatus transactionStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionMockModel({
    required this.transactionId,
    required this.userId,
    required this.secondaryUserPhoneNumber,
    required this.amount,
    this.note,
    required this.transactionDirection,
    required this.transactionType,
    required this.transactionStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionMockModel.fromJson(Map<String, dynamic> json) {
    return TransactionMockModel(
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      secondaryUserPhoneNumber: json['secondaryUserPhoneNumber'] as String,
      amount: (json['amount'] as num).toDouble(),
      note: json['note'] as String?,
      transactionDirection: TransactionMockDirection.values.byName(json['transactionDirection'] as String),
      transactionType: TransactionMockType.values.byName(json['transactionType'] as String),
      transactionStatus: TransactionMockStatus.values.byName(json['transactionStatus'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'secondaryUserPhoneNumber': secondaryUserPhoneNumber,
      'amount': amount,
      'note': note,
      'transactionDirection': transactionDirection.name,
      'transactionType': transactionType.name,
      'transactionStatus': transactionStatus.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

enum TransactionMockDirection { CREDIT, DEBIT }

enum TransactionMockStatus { PENDING, COMPLETED, FAILED, CANCELLED }

enum TransactionMockType { TRANSFER, PAYMENT, REFUND }
