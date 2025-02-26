import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/dashboard_service.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Auto Login System
  void checkAutologin() async {
    var authBox = Hive.box(Constants.instances.authbox);
    var _userBox = await Hive.openBox<UserModel>(Constants.instances.userBox);
    String? userId = authBox.get(Constants.instances.userID);
    String? role = authBox.get(Constants.instances.role);

    if (userId != null && role != null) {
      Constants.instances.currentRole = role;
      Constants.instances.currentUser =
          _userBox.get(Constants.instances.currentUserKey)!;
      DashboardService.instance.gotodashboard(role);
    } else {
      NavigationService.navigateToAndRemove(LoginPage());
    }
  }

  Future<void> logoutUser() async {
    var _userBox = await Hive.openBox<UserModel>(Constants.instances.userBox);
    var authBox = Hive.box(Constants.instances.authbox);
    await authBox.clear();
    await _userBox.delete(Constants.instances.currentUserKey);
    NavigationService.navigateToAndRemove(LoginPage());
  }

  ////login method
  Future<UserCredential?> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
  }

  //fetch Role
  Future<String?> fetchRole(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(Constants.instances.Users).doc(id).get();

      if (doc.exists) {
        var _userC = await Hive.openBox<UserModel>(Constants.instances.userBox);
        UserModel _user =
            UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        Constants.instances.currentUser = _user;
        Constants.instances.currentRole = _user.role;
        _userC.put(Constants.instances.currentUserKey, _user);
        return _user.role;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching role: $e");
      return null;
    }
  }

  // Function to update the role of a user
  Future<void> updateUserRole(
      String userId, String newRole, BuildContext context) async {
    try {
      await _firestore
          .collection(Constants.instances.Users)
          .doc(userId)
          .update({'role': newRole});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Role updated successfully!")),
      );
    } catch (e) {
      print("Error updating role: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update role")),
      );
    }
  }

  ////adding user
  Future<String?> addUser({
    required String name,
    required String email,
    required String role,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: "TemporaryPassword123",
      );

      String userId = userCredential.user!.uid;

      UserModel newUser = UserModel(
        id: userId,
        name: name,
        email: email,
        role: role,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(Constants.instances.Users)
          .doc(userId)
          .set(newUser.toMap());

      await _auth.sendPasswordResetEmail(email: email);

      return "User added successfully! Password reset email sent.";
    } catch (e) {
      print("Error adding user: $e");
      return "Failed to add user: ${e.toString()}";
    }
  }
}
