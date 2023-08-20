import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/Wrapper.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      userStreamController.add(user);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = result.user;

      userStreamController.add(user);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();

      userStreamController.add(null);

      return true;
    } catch (e) {
      print("ERROR WHILE SIGNING OUT: ${e.toString()}");
      return false;
    }
  }
}