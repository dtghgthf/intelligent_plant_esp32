import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/BorderBoxButton.dart';
import 'package:intelligent_plant_esp32/custom/Cards/CardButton.dart';
import 'package:intelligent_plant_esp32/custom/Cards/SettingsCard.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/main.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';
import 'package:intelligent_plant_esp32/utils/auth.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';
import 'package:intelligent_plant_esp32/utils/widget_functions.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback updateTheme;

  const SettingsScreen({super.key, required this.updateTheme});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _SettingsScreenState extends State<SettingsScreen> {
  final storageRef = FirebaseStorage.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    Size screenSize = MediaQuery.of(context).size;

    return _auth.currentUser != null ? Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                addVerticalSpace(50),
                CircleAvatar(
                  backgroundColor: COLOR_GREY,
                  backgroundImage: _auth.currentUser!.isAnonymous ? NetworkImage(ANONYMOUS_PHOTO_URL) : _auth.currentUser!.photoURL != null ? NetworkImage(_auth.currentUser!.photoURL!) : null,
                  radius: 100,
                ),
                addVerticalSpace(15),
                Text(
                    _auth.currentUser!.isAnonymous
                        ? "Anonymous"
                        : (_auth.currentUser!.displayName != null && _auth.currentUser!.displayName?.trim() != "")
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
                            }
                          ),
                        ],
                      )),
                      addVerticalSpace(15),
                      CardButton(
                        onTap: () async {

                          _auth.currentUser!.isAnonymous ? await _authService.deleteUser(context, _auth.currentUser!) : null;

                          await _authService.signOut(context);
                          setState(() {

                          });
                        },
                        child: Text("Log Out",
                          style: screenSize.width < BREAK_SCREEN_SIZE ? TEXT_THEME_SMALL_RED.headlineMedium : TEXT_THEME_DEFAULT_RED.headlineMedium,
                        ),
                      ),
                      addVerticalSpace(15),
                      _auth.currentUser!.isAnonymous ? const SizedBox(width: 0, height: 0) : CardButton(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Are you sure you want to continue?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Continue'),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _authService.deleteUser(context, _auth.currentUser!);
                                      await _authService.signOut(context);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Delete Account",
                          style: screenSize.width < BREAK_SCREEN_SIZE ? TEXT_THEME_SMALL_RED.headlineMedium : TEXT_THEME_DEFAULT_RED.headlineMedium,
                        ),
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
    ) : MyApp();
  }
}

Future<bool> isDarkmodeActiveForCurrentUser() async {
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');

  DocumentSnapshot _data = await userDoc.get();

  print("darkmode is set to: ${_data["settings"]}");

  return _data["settings"]["darkmodeActive"];
}

void setDarkMode(bool active) {
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');

  print("set darkmode to: $active");

  userDoc.update({
    "settings": {
      "darkmodeActive": false
    }
  });
}