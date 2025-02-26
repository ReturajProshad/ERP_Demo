import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTransaction(
      String type, double amount, String category, String description) async {
    try {
      await _firestore.collection("transactions").add({
        "date": DateTime.now().toIso8601String(),
        "amount": amount,
        "type": type,
        "category": category,
        "description": description,
      });
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  Future<void> deleteTransaction(String docId) async {
    try {
      await _firestore.collection("transactions").doc(docId).delete();
    } catch (e) {
      print("Error deleting transaction: $e");
    }
  }

  Stream<QuerySnapshot> getTransactionsStream() {
    return _firestore.collection("transactions").snapshots();
  }
}
