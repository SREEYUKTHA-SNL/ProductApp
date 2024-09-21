import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Firestore

class Firebaseauthservices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Signup function with optional name and phone number
  Future<void> signup({
    required String email,
    required String password,
    String? name, // Optional name
    String? phoneNumber, // Optional phone number
  }) async {
    try {
      // Create a new user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Store the user data in Firestore (optional data can be passed)
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'uid': uid,
        if (name != null) 'name': name, // Store name if provided
        if (phoneNumber != null)
          'phoneNumber': phoneNumber, // Store phone number if provided
      });
    } catch (e) {
      rethrow;
    }
  }

  // Login function remains unchanged
  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isloggedin', true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isloggedin', false);
    } catch (e) {
      rethrow;
    }
  }
}
