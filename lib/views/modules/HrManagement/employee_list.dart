import 'package:erp_d_and_a/views/modules/HrManagement/add_employee.dart';
import 'package:flutter/material.dart';
import 'package:erp_d_and_a/models/employee_model.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:provider/provider.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  void initState() {
    super.initState();
    final hrProvider = Provider.of<HrProvider>(context, listen: false);
    hrProvider.fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    final hrProvider = Provider.of<HrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              NavigationService.navigateTo(AddEmployeePage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: hrProvider.employees.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: hrProvider.employees.length,
                itemBuilder: (context, index) {
                  return _employeeList(
                    hrProvider.employees[index],
                  );
                },
              ),
      ),
    );
  }

  Widget _employeeList(EmployeeModel employee) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(employee.name.substring(0, 1)),
      ),
      title: Text(employee.name),
      subtitle: Text('${employee.designation} | ${employee.department}'),
      trailing: Text("\$${employee.salary.toStringAsFixed(2)}"),
      onTap: () {},
    );
  }
}
