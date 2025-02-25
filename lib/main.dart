import 'package:erp_d_and_a/firebase_options.dart';
import 'package:erp_d_and_a/providers/provider_bindings.dart';
import 'package:erp_d_and_a/services/navigation_service.dart';
import 'package:erp_d_and_a/views/admin_dashboard.dart';
import 'package:erp_d_and_a/views/login_page.dart';
import 'package:erp_d_and_a/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Appinstances.bindProviders(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ERP ODCL",
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
