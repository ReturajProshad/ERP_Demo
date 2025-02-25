import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user_model.dart';
import 'add_user.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    // Fetch users to check the logged-in user's role
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.deepPurple,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUserPage()));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAdminDashboard(BuildContext context) {
    // Use MediaQuery to get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(
          screenWidth * 0.05), // Dynamic padding based on screen size
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          const Text(
            "Welcome, Admin",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Section for Overview of all modules
          const Text("Admin Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: screenHeight * 0.02),
          _buildModuleCard("Users", Icons.person, screenWidth),
          _buildModuleCard("Inventory", Icons.shopping_cart, screenWidth),
          _buildModuleCard("HR", Icons.work, screenWidth),
          _buildModuleCard("Finance", Icons.account_balance, screenWidth),
        ],
      ),
    );
  }

  // Method to create a card for each module with dynamic layout
  Widget _buildModuleCard(String title, IconData icon, double screenWidth) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: screenWidth * 0.04), // Dynamic margin
      child: ListTile(
        leading: Icon(icon,
            size: screenWidth * 0.1, color: Colors.deepPurple), // Scaled icon
        title: Text(
          title,
          style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600), // Scaled text
        ),
        onTap: () {
          // Navigate to the respective page for the selected module
        },
      ),
    );
  }
}
