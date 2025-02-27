import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int idx = 0;

  bool get isFinance =>
      Constants.instances.currentRole == Constants.instances.finance;
  int get currentIndex => idx;

  void setIndex(int index) {
    idx = index;
    pageController.jumpToPage(
      index,
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
