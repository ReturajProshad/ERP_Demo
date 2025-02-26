import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/login_page.dart';
import 'package:erp_d_and_a/views/modules/finance_page.dart';
import 'package:erp_d_and_a/views/modules/hr_page.dart';
import 'package:erp_d_and_a/views/modules/inventory_module.dart';
import 'package:erp_d_and_a/views/modules/user_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';
import 'add_user.dart';

class AdminDashboard extends StatefulWidget {
  final String name;
  AdminDashboard({required this.name});
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text("Admin Dashboard"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.instances.AppbarColorLight,
              //      stops: [.45, .65],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _authService.logoutUser();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Constants.instances.currentRole == null
          ? const Center(child: CircularProgressIndicator())
          : Constants.instances.currentRole == Constants.instances.admin
              ? _buildAdminDashboard(
                  context) // If user is Admin, show the admin dashboard
              : const Center(
                  child: Text("Access Denied",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildAdminDashboard(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //UserModel _currentUser = Constants.instances.currentUser;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, ${widget.name}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.02),
          _buildModuleCard(
              Constants.instances.Users, Icons.person, screenWidth, context),
          _buildModuleCard(Constants.instances.inventory, Icons.shopping_cart,
              screenWidth, context),
          _buildModuleCard(
              Constants.instances.hr, Icons.work, screenWidth, context),
          _buildModuleCard(Constants.instances.finance, Icons.account_balance,
              screenWidth, context),
        ],
      ),
    );
  }

  Widget _buildModuleCard(
      String title, IconData icon, double screenWidth, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: ListTile(
        leading: Icon(icon, size: screenWidth * 0.1, color: Colors.deepPurple),
        title: Text(
          title,
          style: TextStyle(
              fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          if (title == Constants.instances.Users) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UsersPage()));
          } else if (title == Constants.instances.inventory) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InventoryPage()));
          } else if (title == Constants.instances.hr) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HrPage(
                          role: '',
                        )));
          } else if (title == Constants.instances.finance) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FinancePage()));
          }
        },
      ),
    );
  }
}
