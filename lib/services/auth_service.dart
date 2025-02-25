import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ////login method
  Future<UserCredential?> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      // Authenticate with Firebase using email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
  }

  //fetch Role
  Future<String?> fetchRole(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(Constants.instances.Users).doc(id).get();

      if (doc.exists) {
        UserModel _user =
            UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        Constants.instances.currentUser = _user;
        Constants.instances.currentRole = _user.role;
        return _user.role;
      } else {
        return null; // Return null if the document does not exist
      }
    } catch (e) {
      print("Error fetching role: $e");
      return null; // Return null in case of an error
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
