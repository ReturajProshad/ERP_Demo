import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hi ${Constants.instances.currentUser.name}"),
        actions: [
          IconButton(
              onPressed: () {
                _authService.logoutUser();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: const Center(
          child: Center(
              child: Text(
                  "Employee details and leave request can be implement there"))),
    );
  }
}
