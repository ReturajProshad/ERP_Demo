import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Constants _constants = Constants.instances;
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection(_constants.Users).get();
      _users = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data(), doc.id))
          .toList();
      print(_users.length);
      notifyListeners();
    } catch (e) {
      print("Error $e");
    }
  }
}
