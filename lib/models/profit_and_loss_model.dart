class ProfitLossModel {
  final String month;
  final double totalIncome;
  final double totalExpense;
  final double netProfit;

  ProfitLossModel({
    required this.month,
    required this.totalIncome,
    required this.totalExpense,
    required this.netProfit,
  });

  factory ProfitLossModel.fromMap(Map<String, dynamic> map) {
    return ProfitLossModel(
      month: map['month'] ?? '',
      totalIncome: (map['totalIncome'] ?? 0).toDouble(),
      totalExpense: (map['totalExpense'] ?? 0).toDouble(),
      netProfit: (map['netProfit'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'netProfit': netProfit,
    };
  }
}
