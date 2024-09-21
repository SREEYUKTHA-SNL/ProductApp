import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productapp/screens/home.dart';
import 'package:productapp/services/firebaseauthservices.dart';
import 'package:productapp/widgets/buttonwidget.dart';
import 'package:productapp/widgets/loginwidget.dart';
 // Import the custom widget

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
void signupHandler({required String email, required String password}) async {
    try {
      await Firebaseauthservices().signup(email: email, password: password,name: _nameController.text,phoneNumber: _phoneController.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.code}')));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Validators
  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
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

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      signupHandler(

                    email: _emailController.text,

                    password: _passwordController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registering...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomLoginField(
                  controller: _nameController,
                  labelText: 'Name',
                  keyboardType: TextInputType.text,
                  validator: _nameValidator,
                ),
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                CustomLoginField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  keyboardType: TextInputType.text,
                  validator: _confirmPasswordValidator,
                ),
                SizedBox(height: 16),
                CustomLoginField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: _phoneValidator,
                ),
                SizedBox(height: 32),
                CustomElevatedButton(label: 'Register', onPressed: _register)
              ],
            ),
          ),
        ),
      ),
    );
 
  }}