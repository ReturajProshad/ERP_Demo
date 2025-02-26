import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/models/employee_model.dart';
import 'package:erp_d_and_a/models/leave_model.dart';
import 'package:erp_d_and_a/models/payroll_model.dart';
import 'package:flutter/material.dart';

class HrProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final Constants _type = Constants.instances;
  List<EmployeeModel> _employees = [];
  List<LeaveRequest> _leaves = [];
  List<Payroll> _payrolls = [];

  List<EmployeeModel> get employees => _employees;
  List<LeaveRequest> get leaves => _leaves;
  List<Payroll> get payrolls => _payrolls;

  Future<void> fetchEmployees() async {
    var _snapshot = await _firebaseFirestore.collection(_type.employees).get();
    _employees = _snapshot.docs
        .map((e) => EmployeeModel.fromMap(e.data(), e.id))
        .toList();
    notifyListeners();
  }

  Future<void> fetchLeaves() async {
    var snapshot = await _firebaseFirestore.collection('leaves').get();
    _leaves =
        snapshot.docs.map((e) => LeaveRequest.fromMap(e.data(), e.id)).toList();
    notifyListeners();
  }

  Future<void> fetchPayrolls() async {
    var snapshot = await _firebaseFirestore.collection('payrolls').get();
    _payrolls =
        snapshot.docs.map((e) => Payroll.fromMap(e.data(), e.id)).toList();
    notifyListeners();
  }

  Future<void> updateLeaveStatus(String id, String status) async {
    await _firebaseFirestore
        .collection('leaves')
        .doc(id)
        .update({'status': status});
    await fetchLeaves();
  }

  Future<String> addEmployee(EmployeeModel employee) async {
    var ref =
        await _firebaseFirestore.collection('employees').add(employee.toMap());
    await fetchEmployees();
    print(ref.id);
    return ref.id;
  }

  Future<void> addPayroll(Payroll payroll) async {
    await _firebaseFirestore.collection('payrolls').add(payroll.toMap());
    await fetchPayrolls();
  }
}
