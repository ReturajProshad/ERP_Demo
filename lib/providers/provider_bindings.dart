import 'package:erp_d_and_a/providers/hr_provider.dart';
import 'package:erp_d_and_a/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appinstances {
  static Widget bindProviders({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => HrProvider())
      ],
      child: child,
    );
  }
}
