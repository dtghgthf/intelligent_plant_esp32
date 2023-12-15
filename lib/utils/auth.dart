import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/Wrapper.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(BuildContext context, String email, String password, String name, NetworkImage picture) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;

      user.updateDisplayName(name);
      user.updatePhotoURL(picture.url);

      firebaseSetup(user);

      userStreamController.add(user);

      return user;
    } catch (e) {
      print(e.toString());
      showErrorSnackbar(context, e);
      return null;
    }
  }

  Future signInAnonymously(BuildContext context) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      userStreamController.add(user);

      return user;
    } catch (e) {
      print(e.toString());
      showErrorSnackbar(context, e);
      return null;
    }
  }

  Future signInWithEmailAndPassword(BuildContext context, String email, password) async {
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
      showErrorSnackbar(context, e);
      return null;
    }
  }

  Future signInWithGoogle(BuildContext context) async {

    GoogleAuthProvider _authProvider = GoogleAuthProvider();

    try {
      UserCredential result = await _auth.signInWithProvider(_authProvider);
      User? user = result.user;

      UserMetadata _metadata = user!.metadata;
      if (_metadata.creationTime == _metadata.lastSignInTime) {
        String _name = user.email!.split("@")[0];
        user.updateDisplayName(_name);
        user.updatePhotoURL("https://firebasestorage.googleapis.com/v0/b/intelligent-plant.appspot.com/o/profilepictures%2FPP_0.png?alt=media&token=26c030d7-cdca-4553-b0a0-c4c22d528a9c");

        firebaseSetup(user);
      }

      userStreamController.add(user);

      return user;
    } catch (e) {
      print(e.toString());
      showErrorSnackbar(context, e);
      return null;
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      userStreamController.add(null);

      return true;
    } catch (e) {
      print("ERROR WHILE SIGNING OUT: ${e.toString()}");
      showErrorSnackbar(context, e);
      return false;
    }
  }

  Future deleteUser(BuildContext context, User user) async {
    try {
      DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${user.uid}');
      await userDoc.delete();

      await user.delete();

      return true;
    } catch (e) {
      print(e.toString());
      showErrorSnackbar(context, e);
      return false;
    }
  }

  Future firebaseSetup(User user) async {
    DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${user.uid}');

    await userDoc.set({
      "plantSpecies": [
        "Unknown"
      ]
      ,"settings": {
        "darkmodeActive": false
      }
    });
  }
}

void showErrorSnackbar(BuildContext context, Object e) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(e.toString().split("] ")[1]),
  ));
}