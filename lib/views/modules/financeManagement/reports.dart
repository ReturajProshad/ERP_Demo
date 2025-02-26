import 'package:erp_d_and_a/models/report_model.dart';
import 'package:erp_d_and_a/providers/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Financial Reports'),
          backgroundColor: Colors.blueAccent),
      body: Consumer<FinancialReportProvider>(
        builder: (context, reportProvider, child) {
          return ListView.builder(
            itemCount: reportProvider.reports.length,
            itemBuilder: (context, index) {
              final report = reportProvider.reports[index];
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  title: Text(report.month,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Total Income: \$${report.totalIncome.toStringAsFixed(2)}'),
                      Text(
                          'Total Expense: \$${report.totalExpense.toStringAsFixed(2)}'),
                      Text(
                          'Net Profit: \$${report.netProfit.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: report.netProfit >= 0
                                  ? Colors.green
                                  : Colors.red)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      reportProvider.removeReport(report.reportId);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReportDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddReportDialog(BuildContext context) {
    final TextEditingController monthController = TextEditingController();
    final TextEditingController incomeController = TextEditingController();
    final TextEditingController expenseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Financial Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: monthController,
                decoration: const InputDecoration(labelText: 'Month'),
              ),
              TextField(
                controller: incomeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total Income'),
              ),
              TextField(
                controller: expenseController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total Expense'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String month = monthController.text;
                final double income =
                    double.tryParse(incomeController.text) ?? 0;
                final double expense =
                    double.tryParse(expenseController.text) ?? 0;

                if (month.isNotEmpty) {
                  Provider.of<FinancialReportProvider>(context, listen: false)
                      .addReport(
                    FinancialReport(
                      reportId:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      month: month,
                      totalIncome: income,
                      totalExpense: expense,
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
