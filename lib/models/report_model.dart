class FinancialReport {
  final String reportId;
  final String month;
  final double totalIncome;
  final double totalExpense;
  final double netProfit;

  FinancialReport({
    required this.reportId,
    required this.month,
    required this.totalIncome,
    required this.totalExpense,
  }) : netProfit = totalIncome - totalExpense;
}
