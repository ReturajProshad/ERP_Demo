class TransactionModel {
  final String id;
  final double amount;
  final String type; //income /Expense
  final String category;
  final String description;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      amount: map["amount"] ?? 0.0,
      type: map["type"] ?? "Expense",
      category: map["category"] ?? "Unknown",
      description: map["description"] ?? "",
      date: DateTime.tryParse(map["date"] ?? "") ?? DateTime.now(),
    );
  }
}
