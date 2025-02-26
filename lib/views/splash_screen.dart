import 'dart:async';

import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;
  double? _deviceHeight;
  double? _deviceWidth;
  final AuthService _authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animController = AnimationController(
      //Logo animation
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    _animController.forward();

    Timer(const Duration(seconds: 2), () {
      _authService.checkAutologin();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   centerTitle: true,
      //   title: Text("ERP"),
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: Constants.instances.AppbarColorLight,
      //         //      stops: [.45, .65],
      //       ),
      //     ),
      //   ),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: Constants.instances.splashScreenColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "assets/logo.png",
                height: _deviceHeight! * .25,
                width: _deviceWidth! * .50,
              ),
            ),
            SizedBox(height: _deviceHeight! * .01),
            Text(
              "Welcome to ODCL ERP",
              style: TextStyle(
                fontSize: _deviceWidth! * .06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: _deviceHeight! * .01),
            Text(
              "Your Digital ERP Solution",
              style: TextStyle(
                fontSize: _deviceWidth! * .04,
                color: Color.fromARGB(255, 34, 30, 30),
              ),
            ),
            SizedBox(height: _deviceHeight! * .05),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
