class LeaveRequest {
  String id;
  String employeeId;
  String type;
  String startDate;
  String endDate;
  String status;

  LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  // Convert Firestore Document to LeaveRequest Object
  factory LeaveRequest.fromMap(Map<String, dynamic> data, String documentId) {
    return LeaveRequest(
      id: documentId,
      employeeId: data['employeeId'] ?? '',
      type: data['type'] ?? 'Casual',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      status: data['status'] ?? 'Pending',
    );
  }

  // Convert LeaveRequest Object to Firestore Document
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'type': type,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }
}
