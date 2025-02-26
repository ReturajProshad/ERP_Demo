import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/models/invoice_model.dart';
import 'package:erp_d_and_a/providers/invoice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Invoices'), backgroundColor: Colors.blueAccent),
      body: Consumer<InvoiceProvider>(
        builder: (context, invoiceProvider, child) {
          return ListView.builder(
            itemCount: invoiceProvider.invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoiceProvider.invoices[index];

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: Icon(
                    invoice.status == 'Paid'
                        ? Icons.check_circle
                        : Icons.pending,
                    color:
                        invoice.status == 'Paid' ? Colors.green : Colors.orange,
                    size: 30,
                  ),
                  title: Text(invoice.clientName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Invoice: ${invoice.invoiceNumber}'),
                      Text(
                          'Date: ${invoice.date.toLocal().toString().split(' ')[0]}'),
                      Text('Total: \$${invoice.amount.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: invoice.status,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (newStatus) {
                            if (newStatus != null) {
                              invoiceProvider.toggleStatus(index);
                            }
                          },
                          items: Constants.instances.invoiceStatus
                              .map((inv) => DropdownMenuItem(
                                  value: inv, child: Text(inv)))
                              .toList(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            invoiceProvider.deleteInvoice(index);
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _showInvoiceDetails(context, invoice);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showInvoiceDetails(BuildContext context, Invoice invoice) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Invoice Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Invoice Number: ${invoice.invoiceNumber}"),
              Text("Client: ${invoice.clientName}"),
              Text("Date: ${invoice.date.toLocal().toString().split(' ')[0]}"),
              Text("Total: \$${invoice.amount.toStringAsFixed(2)}"),
              Text("Status: ${invoice.status}"),
              const SizedBox(height: 10),
              const Text("Items:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...invoice.items.map((item) => Text(
                  "${item.quantity}x ${item.description} - \$${item.price.toStringAsFixed(2)}")),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
