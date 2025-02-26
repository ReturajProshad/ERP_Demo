import 'package:erp_d_and_a/models/report_model.dart';
import 'package:flutter/material.dart';

class FinancialReportProvider extends ChangeNotifier {
  final List<FinancialReport> _reports = [
    FinancialReport(
        reportId: 'RPT001',
        month: 'January 2024',
        totalIncome: 5000,
        totalExpense: 2000),
    FinancialReport(
        reportId: 'RPT002',
        month: 'February 2024',
        totalIncome: 6200,
        totalExpense: 2500),
    FinancialReport(
        reportId: 'RPT003',
        month: 'March 2024',
        totalIncome: 4500,
        totalExpense: 1800),
  ];

  List<FinancialReport> get reports => _reports;

  void addReport(FinancialReport report) {
    _reports.add(report);
    notifyListeners();
  }

  void removeReport(String reportId) {
    _reports.removeWhere((report) => report.reportId == reportId);
    notifyListeners();
  }
}
