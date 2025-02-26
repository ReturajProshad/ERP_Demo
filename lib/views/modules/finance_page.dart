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
  bool isfin = Constants.instances.currentRole == Constants.instances.finance;
  int _idx = 0;
  final PageController _pageController = PageController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _idx = index;
          });
        },
        children: [
          BillingPage(),
          InvoicesPage(),
          FinancialReportPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        enableFeedback: true,
        selectedFontSize: _width * 0.04,
        unselectedFontSize: _width * 0.03,
        selectedIconTheme: IconThemeData(size: _width * 0.08),
        unselectedIconTheme: IconThemeData(size: _width * 0.06),
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _idx = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Billing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: "Invoices"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report")
        ],
      ),
      floatingActionButton: isfin
          ? FloatingActionButton(
              onPressed: () {
                _authService.logoutUser();
              },
              child: const Icon(Icons.logout),
            )
          : Container(),
    );
  }
}
