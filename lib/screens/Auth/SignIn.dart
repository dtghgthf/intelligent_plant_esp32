import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/main.dart';
import 'package:intelligent_plant_esp32/screens/Wrapper.dart';
import 'package:intelligent_plant_esp32/utils/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Sign in Anonymous"),
                onPressed: () async {
                  dynamic result = await _auth.signInAnonymous();
                  if (result != null) {
                    print("Signed in: $result}");
                  } else {
                    print("Error Signing In");
                  }
                },
              ),
              ElevatedButton(
                child: Text("Sign in With Email and Password"),
                onPressed: () async {
                  dynamic result = await _auth.signInWithEmailAndPassword("erik.echterhoff@gmail.com", "test123");
                  if (result != null) {
                    print("Signed in: $result}");
                  } else {
                    print("Error Signing In");
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}
