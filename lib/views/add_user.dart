import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedRole = 'Employee';
  final AuthService _authService = AuthService();

  Future<void> _handleAddUser() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter all fields")));
      return;
    }

    String? response = await _authService.addUser(
        name: name, email: email, role: _selectedRole);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response ?? "Unknown error")));

    if (response == "User added successfully! Password reset email sent.") {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New User")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            DropdownButton<String>(
              value: _selectedRole,
              items: Constants.instances.dropDownitems
                  .map((role) =>
                      DropdownMenuItem(value: role, child: Text(role)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleAddUser,
              child: Text("Add User"),
            )
          ],
        ),
      ),
    );
  }
}
