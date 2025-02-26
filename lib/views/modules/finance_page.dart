import 'package:erp_d_and_a/views/modules/financeManagement/profitAndLoss.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/transactions_page.dart';
import 'package:flutter/material.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  int _idx = 0;
  final List<Widget> _pages = [TransactionsPage(), Profitandloss()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _idx,
          onTap: (index) {
            setState(() {
              _idx = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: "Transactions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics), label: "Profit & Loss")
          ]),
    );
  }
}
