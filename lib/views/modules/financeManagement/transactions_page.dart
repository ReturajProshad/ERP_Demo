import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erp_d_and_a/services/transaction_service.dart';
import 'package:erp_d_and_a/models/transaction_model.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionService _transactionService = TransactionService();

  Future<void> _showAddTransactionDialog(String type) async {
    TextEditingController amountController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add $type"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              double amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                await _transactionService.addTransaction(
                  type,
                  amount,
                  categoryController.text,
                  descriptionController.text,
                );
              }
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transactions")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _transactionService.getTransactionsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No transactions found"));
          }

          List<TransactionModel> transactions = snapshot.data!.docs.map((doc) {
            return TransactionModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          }).toList();

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              TransactionModel transaction = transactions[index];

              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  leading: Icon(
                    transaction.type == "Income" ? Icons.add : Icons.remove,
                    color: transaction.type == "Income"
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(
                    "${transaction.amount.toStringAsFixed(2)} - ${transaction.category}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(transaction.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _transactionService.deleteTransaction(transaction.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            label: Text("Add Income"),
            icon: Icon(Icons.add),
            onPressed: () => _showAddTransactionDialog("Income"),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            label: Text("Add Expense"),
            icon: Icon(Icons.remove),
            onPressed: () => _showAddTransactionDialog("Expense"),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
