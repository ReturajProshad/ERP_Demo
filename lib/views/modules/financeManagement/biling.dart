import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/providers/biling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biling Report'),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          Consumer<BillingProvider>(builder: (context, bilingProvider, child) {
        return Padding(
          padding: EdgeInsets.all(_width * 0.02),
          child: ListView.builder(
            itemCount: bilingProvider.billdata.length,
            itemBuilder: (context, index) {
              final billing = bilingProvider.billdata[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: _width * 0.02),
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.all(_width * 0.03),
                  child: Row(
                    children: [
                      Icon(
                        billing.status == 'Paid'
                            ? Icons.check_circle
                            : Icons.pending,
                        color: billing.status == 'Paid'
                            ? Colors.green
                            : Colors.orange,
                        size: _width * 0.07,
                      ),
                      SizedBox(width: _width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoice: ${billing.invoiceNumber}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: _width * 0.04),
                            ),
                            Text(billing.clientName),
                            Text('\$${billing.amount.toStringAsFixed(2)}'),
                          ],
                        ),
                      ),
                      DropdownButton<String>(
                        value: billing.status,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (newStatus) {
                          bilingProvider.toggleStatus(index);
                        },
                        items: Constants.instances.BilingreportStatus
                            .map((el) =>
                                DropdownMenuItem(value: el, child: Text("$el")))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
