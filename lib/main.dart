import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productapp/firebase_options.dart';
import 'package:productapp/screens/home.dart';
import 'package:productapp/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAuthenticated = prefs.getBool('isloggedin') ?? false;
  runApp(MaterialApp(home: isAuthenticated ? HomePage() : LoginPage()));
}
