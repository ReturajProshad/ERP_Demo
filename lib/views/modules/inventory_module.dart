import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/models/inventory_model.dart';
import 'package:erp_d_and_a/services/inventory_service.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final InventoryService _inventoryService = InventoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory Management"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<InventoryModel>>(
        stream: _inventoryService.getInventoryItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No items in inventory"));
          }

          List<InventoryModel> items = snapshot.data!;

          return Column(
            children: [
              //  Stack(
              //    children: [], //i'll add something later
              //  ),
              _inventoryCards(items)
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddInventoryDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _inventoryCards(List<InventoryModel> items) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          InventoryModel item = items[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: const Icon(Icons.inventory, color: Colors.blue),
              title: Text(item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  "Category: ${item.category} | Quantity: ${item.quantity}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    onPressed: () {
                      if (item.quantity > 0) {
                        _inventoryService.updateInventoryQuantity(
                            item.id, item.quantity - 1);
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: () {
                      _inventoryService.updateInventoryQuantity(
                          item.id, item.quantity + 1);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddInventoryDialog(BuildContext context) {
    String name = "";
    String category = "";
    String supplier = "";
    int quantity = 0;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Item Name"),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Category"),
                onChanged: (value) => category = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Supplier"),
                onChanged: (value) => supplier = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = double.tryParse(value) ?? 0.0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  InventoryModel newItem = InventoryModel(
                    id: "",
                    name: name,
                    category: category,
                    quantity: quantity,
                    price: price,
                    supplier: supplier,
                    lastUpdated: Timestamp.now(),
                  );
                  _inventoryService.addInventoryItem(newItem);
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
