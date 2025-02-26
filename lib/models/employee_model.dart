class EmployeeModel {
  String id;
  String name;
  String designation;
  String department;
  String status;
  double salary;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.status,
    required this.salary,
  });

  // Convert Firestore Document to EmployeeModel Object
  factory EmployeeModel.fromMap(Map<String, dynamic> data, String documentId) {
    return EmployeeModel(
      id: documentId,
      name: data['name'] ?? '',
      designation: data['designation'] ?? '',
      department: data['department'] ?? '',
      status: data['status'] ?? 'Active',
      salary: (data['salary'] ?? 0.0).toDouble(),
    );
  }

  // Convert Employee Object to Firestore Document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'designation': designation,
      'department': department,
      'status': status,
      'salary': salary,
    };
  }
}
