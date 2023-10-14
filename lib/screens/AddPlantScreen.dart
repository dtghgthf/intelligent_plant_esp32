import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_plant_esp32/custom/Cards/CardButton.dart';
import 'package:intelligent_plant_esp32/custom/Cards/SettingsCard.dart';
import 'package:intelligent_plant_esp32/custom/CustomTextField.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';

import '../custom/BorderBoxButton.dart';
import '../utils/TempData.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';

class AddPlantScreen extends StatefulWidget {
  final VoidCallback updatePage;

  const AddPlantScreen({super.key, required this.updatePage});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

TextEditingController _nameController = TextEditingController();

PLANT_SPECIES _selectedSpecies = PLANT_SPECIES.Unknown;

final FirebaseAuth _auth = FirebaseAuth.instance;

class _AddPlantScreenState extends State<AddPlantScreen> {

  @override
  void initState() {
    super.initState();

    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Column(
              children: [
                addVerticalSpace(15),
                Text("Add Plant", style: themeData.textTheme.displayLarge),
                addVerticalSpace(50),
                CustomTextField(
                  text: "Name",
                  controller: _nameController,
                ),
                addVerticalSpace(15),
                SettingsCard(
                  width: screenSize.width - (screenSize.width / 5),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Species", style: themeData.textTheme.labelLarge),
                      DropdownButton<PLANT_SPECIES>(
                        value: _selectedSpecies,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSpecies = newValue!;
                          });
                        },
                        items: PLANT_SPECIES.values.map((PLANT_SPECIES species) {
                          return DropdownMenuItem<PLANT_SPECIES>(
                            value: species,
                            child: Text(species.name, style: themeData.textTheme.bodyLarge),
                          );
                        }).toList() + [ //TODO: Add these functions in Species Dropdown
                          DropdownMenuItem(
                            child: Text("ADD PLANT", style: themeData.textTheme.bodyLarge),
                            onTap: () {

                            },
                          ),
                          DropdownMenuItem(
                            child: Text("DELETE LAST", style: TEXT_THEME_DEFAULT_RED.bodyLarge),
                            onTap: () {

                            },
                          ),
                          DropdownMenuItem(
                            child: Text("DELETE ALL", style: TEXT_THEME_DEFAULT_RED.bodyLarge),
                            onTap: () {

                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //TODO: add Image
                addVerticalSpace(50),
                CardButton(
                  onTap: () {
                    addPlant();
                    Navigator.pop(context);
                    widget.updatePage.call();
                  },
                  child: Text("Add Plant", style: themeData.textTheme.displayMedium),
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
              child: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}

Future addPlant() async {
  CollectionReference plantsCollection = FirebaseFirestore.instance.collection('Users/${_auth.currentUser!.uid}/Plants');

  int plantsCount = await countFieldsInCollection(plantsCollection.path);

  String id = getRandomString(10);

  plantsCollection.doc("plant_${plantsCount}").set({
    "Id": id,
    "Name": _nameController.text,
    "Species": _selectedSpecies.name,
    "ImageURL": "", // TODO: Add Image URL to plant
    "data": {
      "Water": {
        "inPercent": 0,
        "unneutralized": 0
      },
      "Temperature": {
        "inPercent": 0,
        "in°C": 0,
        "in°F": 0
      },
      "Light": {
        "inPercent": 0,
        "inLux": 0,
        "unneutralized": 0
      }
    }
  });
}