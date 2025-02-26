import 'package:erp_d_and_a/models/invoice_model.dart';
import 'package:flutter/material.dart';

class InvoiceProvider extends ChangeNotifier {
  final List<Invoice> _invoices = [
    Invoice(
      invoiceNumber: 'INV1001',
      clientName: 'John Doe',
      date: DateTime(2024, 2, 20),
      amount: 250.00,
      status: 'Unpaid',
      items: [
        InvoiceItem(
            description: 'Web Design Services', quantity: 1, price: 250.00),
      ],
    ),
    Invoice(
      invoiceNumber: 'INV1002',
      clientName: 'Jane Smith',
      date: DateTime(2024, 2, 18),
      amount: 500.00,
      status: 'Paid',
      items: [
        InvoiceItem(
            description: 'Mobile App Development', quantity: 1, price: 500.00),
      ],
    ),
    Invoice(
      invoiceNumber: 'INV1003',
      clientName: 'Acme Corp',
      date: DateTime(2024, 2, 15),
      amount: 150.00,
      status: 'Unpaid',
      items: [
        InvoiceItem(description: 'SEO Services', quantity: 1, price: 150.00),
      ],
    ),
  ];
  List<Invoice> get invoices => _invoices;

  void toggleStatus(int index) {
    _invoices[index].status =
        _invoices[index].status == 'Paid' ? 'Unpaid' : 'Paid';
    notifyListeners();
  }

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
    notifyListeners();
  }

  void deleteInvoice(int index) {
    _invoices.removeAt(index);
    notifyListeners();
  }
}
