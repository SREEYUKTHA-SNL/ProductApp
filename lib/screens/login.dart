import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productapp/screens/home.dart';
import 'package:productapp/screens/register.dart';
import 'package:productapp/services/firebaseauthservices.dart';
import 'package:productapp/widgets/buttonwidget.dart'; // Import the custom button
import 'package:productapp/widgets/loginwidget.dart'; // Import the custom login field

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false; // Loading state to track if login is in progress

  Future<void> loginHandler({required String email, required String password}) async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      await Firebaseauthservices().login(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Successful')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Login Failed...')));
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomLoginField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
              ),
              SizedBox(height: 16),
              CustomLoginField(
                controller: _passwordController,
                labelText: 'Password',
                keyboardType: TextInputType.text,
                validator: _passwordValidator,
              ),
              SizedBox(height: 32),
              isLoading
                  ? Center(child: CircularProgressIndicator()) // Show loading indicator
                  : CustomElevatedButton(
                      label: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginHandler(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Register here', style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
