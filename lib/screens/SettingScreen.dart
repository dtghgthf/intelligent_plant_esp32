import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/BorderBoxButton.dart';
import 'package:intelligent_plant_esp32/custom/Cards/SettingsCard.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';
import 'package:intelligent_plant_esp32/utils/widget_functions.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback updateTheme;

  const SettingsScreen({super.key, required this.updateTheme});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    Size screenSize = window.physicalSize;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                addVerticalSpace(50),
                CircleAvatar(
                  backgroundColor: COLOR_GREY,
                  radius: 100,
                ),
                addVerticalSpace(15),
                Text(
                    _auth.currentUser!.isAnonymous
                        ? "Anonymous"
                        : _auth.currentUser!.displayName != null
                            ? _auth.currentUser!.displayName!
                            : _auth.currentUser!.email!,
                    style: themeData.textTheme.headlineMedium),
                addVerticalSpace(50),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SettingsCard(child: Row(
                        children: [
                          addHorizontalSpace(10),
                          Text("Dark Mode",
                              style: themeData.textTheme.headlineMedium),
                          addHorizontalSpace(10),
                          Spacer(),
                          Switch(
                            value: DARKMODE_ACTIVE,
                            onChanged: (active) {
                              DARKMODE_ACTIVE = active;
                              widget.updateTheme();
                            },
                          )
                        ],
                      )),
                      addVerticalSpace(15),
                      SettingsCard(
                        child: Center(
                          child: Text("Log Out",
                            style: screenSize.width < BREAK_SCREEN_SIZE ? TEXT_THEME_SMALL_RED.headlineMedium : TEXT_THEME_DEFAULT_RED.headlineMedium,
                          )
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: BorderBoxButton(
              width: 50,
              height: 50,
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
