import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/add_user.dart';
import 'package:flutter/material.dart';
import 'package:erp_d_and_a/models/user_model.dart';
import 'package:erp_d_and_a/customWidgets/Contants.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  String currentUserId = Constants.instances.currentUser.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.instances.AppbarColorLight,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(Constants.instances.Users).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          List<UserModel> users = snapshot.data!.docs
              .map((doc) {
                return UserModel.fromMap(
                    doc.data() as Map<String, dynamic>, doc.id);
              })
              .where((user) => user.id != currentUserId)
              .toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserModel user = users[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user.email),
                  trailing: DropdownButton<String>(
                    value: user.role,
                    items: Constants.instances.dropDownitems
                        .map(
                          (role) =>
                              DropdownMenuItem(value: role, child: Text(role)),
                        )
                        .toList(),
                    onChanged: (newRole) {
                      if (newRole != null) {
                        _auth.updateUserRole(user.id, newRole, context);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.navigateTo(AddUserPage());
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
