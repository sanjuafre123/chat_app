import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Account Create - Sign Up

  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Login Sign In
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try
        {
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
          return "success";
        }catch(e)
    {
      return e.toString();
    }
  }

  //Sign Out
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  // Get Current User

  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      log("email : ${user.email}");
    }
    return user;
  }
}
