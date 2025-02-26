import 'package:erp_d_and_a/providers/biling_provider.dart';
import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:erp_d_and_a/providers/invoice_provider.dart';
import 'package:erp_d_and_a/providers/report_provider.dart';
import 'package:erp_d_and_a/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appinstances {
  static Widget bindProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => HrProvider()),
        ChangeNotifierProvider(create: (context) => InvoiceProvider()),
        ChangeNotifierProvider(create: (context) => BillingProvider()),
        ChangeNotifierProvider(create: (context) => FinancialReportProvider())
      ],
      child: child,
    );
  }
}
