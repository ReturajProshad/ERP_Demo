import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/providers/finance_provider.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/biling.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/invoices.dart';
import 'package:erp_d_and_a/views/modules/financeManagement/reports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    AuthService _authService = AuthService();
    final _finaceProvider = Provider.of<FinanceProvider>(context);
    return Scaffold(
      body: PageView(
        controller: _finaceProvider.pageController,
        onPageChanged: (index) {
          _finaceProvider.setIndex(index);
        },
        children: [
          BillingPage(),
          InvoicesPage(),
          FinancialReportPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _finaceProvider.currentIndex,
        enableFeedback: true,
        selectedFontSize: _width * 0.04,
        unselectedFontSize: _width * 0.03,
        selectedIconTheme: IconThemeData(size: _width * 0.08),
        unselectedIconTheme: IconThemeData(size: _width * 0.06),
        onTap: (index) {
          _finaceProvider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Billing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Invoices"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report")
        ],
      ),
      floatingActionButton: _finaceProvider.isFinance
          ? FloatingActionButton(
              onPressed: () {
                _authService.logoutUser();
              },
              child: const Icon(Icons.logout),
            )
          : null,
    );
  }
}
