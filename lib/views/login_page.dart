import 'dart:ffi';

import 'package:erp_d_and_a/customWidgets/Contants.dart';
import 'package:erp_d_and_a/services/dashboard_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:erp_d_and_a/services/auth_service.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _optacityanimation;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _optacityanimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.deepPurple,
      ),
      body: FadeTransition(
        opacity: _optacityanimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 30),
                // Email input field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA0-9.-]+\.[a-zA-Z]{2,4}$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                // Login button
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: Colors.purple),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential? userCredential =
            await _authService.signInWithEmailPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (userCredential != null && userCredential.user != null) {
          String id = userCredential.user!.uid;
          String? _role = await _authService.fetchRole(id);
          print(_role);

          //saving the Authentication Details
          var _authbox = Hive.box(Constants.instances.authbox);

          _authbox.put(Constants.instances.userID, id);
          _authbox.put(Constants.instances.role, _role);
          //fetch user model to PASS from Hive
          DashboardService.instance.gotodashboard(_role!);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    }
  }
}
