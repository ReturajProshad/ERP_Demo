import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _idx = 0;

  bool get isFinance =>
      Constants.instances.currentRole == Constants.instances.finance;
  int get currentIndex => _idx;

  void setIndex(int index) {
    _idx = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
