import 'package:erp_d_and_a/models/employee_model.dart';
import 'package:erp_d_and_a/models/payroll_model.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeePayrollPage extends StatelessWidget {
  const EmployeePayrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hrProvider = Provider.of<HrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Payroll"),
      ),
      body: hrProvider.payrolls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: hrProvider.payrolls.length,
              itemBuilder: (context, index) {
                Payroll payroll = hrProvider.payrolls[index];
                EmployeeModel employee = hrProvider.employees.firstWhere(
                  (emp) => emp.id == payroll.employeeId,
                  orElse: () => EmployeeModel(
                    id: '',
                    name: 'Unknown',
                    designation: '',
                    department: '',
                    status: '',
                    salary: 0,
                  ),
                );

                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('Month: ${payroll.month}'),
                  trailing: Text("\$${payroll.amount.toStringAsFixed(2)}"),
                  leading: Icon(
                    payroll.status == "Paid"
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: payroll.status == "Paid" ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // You can add functionality to view details or update payroll
                  },
                );
              },
            ),
    );
  }
}
