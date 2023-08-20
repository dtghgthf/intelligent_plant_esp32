import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/screens/Auth/AuthentificationScreen.dart';
import 'package:intelligent_plant_esp32/screens/LandingScreen.dart';
import 'package:provider/provider.dart';

StreamController<User?> userStreamController = StreamController<User>.broadcast();

class Wrapper extends StatelessWidget {
  final VoidCallback updateTheme;

  const Wrapper({super.key, required this.updateTheme});

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder(
        stream: userStreamController.stream,
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _auth.currentUser != null ? LandingScreen(updateTheme: updateTheme) : AuthentificationScreen();
          } else if (snapshot.hasError) {
            return Text("ERROR");
          } else if (!snapshot.hasData) {
            return AuthentificationScreen();
          } else {
            return Text(snapshot.toString());
          }
        },
      ),
    );//_auth.currentUser != null ? LandingScreen(updateTheme: updateTheme) : AuthentificationScreen();
  }
}
