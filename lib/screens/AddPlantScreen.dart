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

List<String> species = ["Unknown"];

String _selectedSpecies = "Unknown";

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
                      FutureBuilder(
                        future: getSpecies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {

                            return DropdownButton<String>(
                              value: _selectedSpecies,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedSpecies = newValue!;
                                });
                              },
                              items: snapshot.data!.map((String species) {
                                return DropdownMenuItem<String>(
                                  value: species,
                                  child: Text(species, style: themeData.textTheme.bodyLarge),
                                );
                              }).toList()
                            );
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("ERROR: ${snapshot.error}");
                          } else {
                            return Text("${snapshot.data}");
                          }
                        },
                      )
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
    "Species": _selectedSpecies,
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

Future<List<String>> getSpecies() async {
  List<String> output = [];
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');

  DocumentSnapshot data = await userDoc.get();

  output = List<String>.from(data["plantSpecies"]);

  print("---------------- ${output} -------------------");

  return output;
}

Future addSpecies(String name) async {

}