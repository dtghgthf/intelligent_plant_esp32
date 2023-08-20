import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/screens/Auth/SignIn.dart';

class AuthentificationScreen extends StatefulWidget {
  const AuthentificationScreen({super.key});

  @override
  State<AuthentificationScreen> createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);

    return SignIn();
  }
}
