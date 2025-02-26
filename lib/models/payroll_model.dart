class Payroll {
  String id;
  String employeeId;
  String month;
  double amount;
  String status;

  Payroll({
    required this.id,
    required this.employeeId,
    required this.month,
    required this.amount,
    required this.status,
  });

  // Convert Firestore Document to Payroll Object
  factory Payroll.fromMap(Map<String, dynamic> data, String documentId) {
    return Payroll(
      id: documentId,
      employeeId: data['employeeId'] ?? '',
      month: data['month'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      status: data['status'] ?? 'Pending',
    );
  }

  // Convert Payroll Object to Firestore Document
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'month': month,
      'amount': amount,
      'status': status,
    };
  }
}
