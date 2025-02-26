class Invoice {
  final String invoiceNumber;
  final String clientName;
  final DateTime date;
  final double amount;
  String status;
  final List<InvoiceItem> items;

  Invoice({
    required this.invoiceNumber,
    required this.clientName,
    required this.date,
    required this.amount,
    required this.status,
    required this.items,
  });
}

class InvoiceItem {
  final String description;
  final int quantity;
  final double price;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.price,
  });
}
