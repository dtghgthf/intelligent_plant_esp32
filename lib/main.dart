import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/screens/Auth/SignIn.dart';
import 'dart:ui';
import 'package:intelligent_plant_esp32/screens/LandingScreen.dart';
import 'package:intelligent_plant_esp32/screens/Wrapper.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';
import 'package:intelligent_plant_esp32/utils/auth.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    Widget home = MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: COLOR_WHITE,
            textTheme: GenerateTextTheme(screenSize.width),
            fontFamily: "Montserrat",
            colorScheme: DARKMODE_ACTIVE
                ? const ColorScheme.dark()
                : ColorScheme.fromSwatch()
                    .copyWith(secondary: COLOR_DARK_BLUE)),
        home: Wrapper(updateTheme: () {
          setState(() {});
        })
        /*FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(
                child: Text("SOMETHING WENT WRONG",
                    style: themeData.textTheme.headlineLarge),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Wrapper(updateTheme: () {
                setState(() {});
              });
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(child: CircularProgressIndicator());
          },
        )*/ // LandingScreen(updateTheme: () { setState(() {}); }),
        );

    return SAFEAREA_ACTIVE ? SafeArea(child: home) : home;
  }
}

TextTheme GenerateTextTheme(double screenWidth) {
  if (screenWidth < BREAK_SCREEN_SIZE) {
    return DARKMODE_ACTIVE ? TEXT_THEME_SMALL_DARK : TEXT_THEME_SMALL;
  } else {
    return DARKMODE_ACTIVE ? TEXT_THEME_DEFAULT_DARK : TEXT_THEME_DEFAULT;
  }
}
