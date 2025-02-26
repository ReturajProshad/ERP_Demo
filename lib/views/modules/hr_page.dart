import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:erp_d_and_a/views/modules/HrManagement/employee_list.dart';
import 'package:erp_d_and_a/views/modules/inventory_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:erp_d_and_a/models/employee_model.dart';
import 'package:erp_d_and_a/models/payroll_model.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/modules/HrManagement/leaveRequest_page.dart';
import 'package:erp_d_and_a/views/modules/HrManagement/payroll_page.dart';

class HrPage extends StatefulWidget {
  String role;
  HrPage({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<HrPage> createState() => _HrPageState();
}

class _HrPageState extends State<HrPage> {
  @override
  void initState() {
    final hrProvider = Provider.of<HrProvider>(context, listen: false);
    hrProvider.fetchEmployees();
    hrProvider.fetchLeaves();
    hrProvider.fetchPayrolls();
    super.initState();
  }

  AuthService _authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    bool isHR = (widget.role == Constants.instances.hr) ? true : false;

    final hrProvider = Provider.of<HrProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HR Management"),
        actions: [
          if (isHR) ...[
            IconButton(
              onPressed: () {
                _authservice.logoutUser();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isHR
                ? Text("Welcome ${Constants.instances.currentUser.name}")
                : Container(),
            _buildSectionTitle("Employee Payroll Overview"),
            _buildEmployeeTable(hrProvider.employees, hrProvider.payrolls),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "HR Dashboard",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Employees"),
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateTo(EmployeeListPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text("Payroll"),
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateTo(EmployeePayrollPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.event_note),
            title: const Text("Leave Requests"),
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateTo(LeaveRequestPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Inventory"),
            onTap: () {
              Navigator.pop(context);
              NavigationService.navigateTo(InventoryPage());
            },
          )
        ],
      ),
    );
  }

  Widget _buildEmployeeTable(
      List<EmployeeModel> employees, List<Payroll> payrolls) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.blueAccent),
        columns: const [
          DataColumn(
              label: Text("Employee Name",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Status",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Paid",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Salary",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
        ],
        rows: employees.map((employee) {
          var payroll = payrolls.firstWhere(
            (p) => p.employeeId == employee.id,
            orElse: () => Payroll(
                id: "",
                employeeId: employee.id,
                month: "",
                amount: 0.0,
                status: "Unpaid"),
          );

          return DataRow(cells: [
            DataCell(Text(employee.name)),
            DataCell(Text(employee.status,
                style: TextStyle(
                    color: employee.status == "working"
                        ? Colors.green
                        : Colors.red))),
            DataCell(
              Text(
                payroll.status == "Paid" ? "✅ Paid" : "❌ Unpaid",
                style: TextStyle(
                    color:
                        payroll.status == "Paid" ? Colors.green : Colors.red),
              ),
            ),
            DataCell(Text("\$${employee.salary.toStringAsFixed(2)}")),
          ]);
        }).toList(),
      ),
    );
  }
}
