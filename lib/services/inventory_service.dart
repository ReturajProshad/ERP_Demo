import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/models/inventory_model.dart';

class InventoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "Inventory";

  // Fetch all inventory items
  Stream<List<InventoryModel>> getInventoryItems() {
    return _firestore.collection(collectionPath).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => InventoryModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Add a new inventory item
  Future<void> addInventoryItem(InventoryModel item) async {
    await _firestore.collection(collectionPath).add(item.toMap());
  }

  // Update inventory quantity
  Future<void> updateInventoryQuantity(String id, int newQuantity) async {
    await _firestore.collection(collectionPath).doc(id).update({
      'quantity': newQuantity,
      'lastUpdated': Timestamp.now(),
    });
  }

  // Delete an inventory item
  Future<void> deleteInventoryItem(String id) async {
    await _firestore.collection(collectionPath).doc(id).delete();
  }
}
