import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryModel {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String supplier;
  final Timestamp lastUpdated;

  InventoryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.supplier,
    required this.lastUpdated,
  });

  factory InventoryModel.fromMap(Map<String, dynamic> data, String documentId) {
    return InventoryModel(
      id: documentId,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
      supplier: data['supplier'] ?? '',
      lastUpdated: data['lastUpdated'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
      'supplier': supplier,
      'lastUpdated': lastUpdated,
    };
  }
}
