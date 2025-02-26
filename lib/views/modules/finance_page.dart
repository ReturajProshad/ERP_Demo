import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/biling.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/invoices.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/reports.dart';
import 'package:flutter/material.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  bool isfin = Constants.instances.currentRole == Constants.instances.finance
      ? true
      : false;
  int _idx = 0;
  final List<Widget> _pages = [
    BillingPage(),
    InvoicesPage(),
    FinancialReportPage()
  ];
  AuthService _authService = AuthService();
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
                icon: Icon(Icons.attach_money), label: "Biling"),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics), label: "invoices"),
            BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report")
          ]),
      floatingActionButton: isfin
          ? FloatingActionButton(
              onPressed: () {
                _authService.logoutUser();
              },
              child: Icon(Icons.logout),
            )
          : Container(),
    );
  }
}
