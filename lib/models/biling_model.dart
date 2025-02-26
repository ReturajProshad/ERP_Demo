class Billing {
  final String invoiceNumber;
  final String clientName;
  final double amount;
  String status;

  Billing({
    required this.invoiceNumber,
    required this.clientName,
    required this.amount,
    required this.status,
  });
}
