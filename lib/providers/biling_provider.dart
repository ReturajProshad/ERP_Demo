import 'package:erp_d_and_a/models/biling_model.dart';
import 'package:flutter/material.dart';

class BillingProvider extends ChangeNotifier {
  final List<Billing> _billData = [
    Billing(
      invoiceNumber: 'INV123',
      clientName: 'Client A',
      amount: 1200.50,
      status: 'Paid',
    ),
    Billing(
      invoiceNumber: 'INV124',
      clientName: 'Client B',
      amount: 800.00,
      status: 'Pending',
    ),
    Billing(
      invoiceNumber: 'INV125',
      clientName: 'Client C',
      amount: 1500.75,
      status: 'Paid',
    ),
    Billing(
      invoiceNumber: 'INV126',
      clientName: 'Client D',
      amount: 600.25,
      status: 'Pending',
    ),
  ];
  List<Billing> get billdata => _billData;
  void toggleStatus(int index) {
    _billData[index].status =
        _billData[index].status == 'Paid' ? 'Pending' : 'Paid';
    notifyListeners();
  }
}
