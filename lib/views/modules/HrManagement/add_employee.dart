import 'package:flutter/material.dart';
import 'package:erp_d_and_a/models/employee_model.dart';
import 'package:erp_d_and_a/models/payroll_model.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:provider/provider.dart';

class AddEmployeePage extends StatefulWidget {
  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hrProvider = Provider.of<HrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Employee Name'),
            ),
            TextField(
              controller: _designationController,
              decoration: InputDecoration(labelText: 'Designation'),
            ),
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: _salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final designation = _designationController.text;
                final department = _departmentController.text;
                final salary = double.tryParse(_salaryController.text) ?? 0.0;

                if (name.isNotEmpty && designation.isNotEmpty) {
                  final newEmployee = EmployeeModel(
                    id: '',
                    name: name,
                    designation: designation,
                    department: department,
                    status: 'working',
                    salary: salary,
                  );

                  String _id = await hrProvider.addEmployee(newEmployee);

                  final payroll = Payroll(
                    id: '',
                    employeeId: _id,
                    month: DateTime.now().month.toString(),
                    amount: salary,
                    status: 'Pending',
                  );

                  // Add payroll entry to Firestore
                  await hrProvider.addPayroll(payroll);

                  Navigator.pop(context);
                }
              },
              child: Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
