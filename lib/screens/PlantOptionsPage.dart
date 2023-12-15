import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/Cards/PlantDataCard.dart';
import 'package:intelligent_plant_esp32/screens/LandingScreen.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';
import 'package:intelligent_plant_esp32/utils/plant_functions.dart';

import '../custom/BorderBoxButton.dart';
import '../custom/Objects/Plant.dart';
import '../utils/widget_functions.dart';

class PlantOptionsPage extends StatefulWidget {

  final Plant plant;

  const PlantOptionsPage({super.key, required this.plant});

  @override
  State<PlantOptionsPage> createState() => _PlantOptionsPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _PlantOptionsPageState extends State<PlantOptionsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    CollectionReference _plantsCollection = FirebaseFirestore.instance.collection('Users/${_auth.currentUser!.uid}/Plants');

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                addVerticalSpace(15),
                Text(widget.plant.name, style: themeData.textTheme.displayLarge),
                addVerticalSpace(10),
                Text(widget.plant.species, style: themeData.textTheme.titleMedium),
                addVerticalSpace(50),
                StreamBuilder(
                  stream: _plantsCollection.snapshots(),
                  builder: (context, StreamSnapshot) {
                    if (StreamSnapshot.hasData) {
                      return Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: 3,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            mainAxisSpacing: 10, // Spacing between rows
                            crossAxisSpacing: 10, // Spacing between columns
                            childAspectRatio: 1, // Width to height ratio of each grid item
                          ),
                          itemBuilder: (context, index) {
                            return PlantDataCard(
                              dataType: DATA_TYPES.values[index],
                              width: 230,
                              height: 230,
                              plant: widget.plant,
                            );
                          },
                        ),
                      );
                    } else if (StreamSnapshot.hasError) {
                      return Text("ERROR: ${StreamSnapshot.error}");
                    } else if (!StreamSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Text("${StreamSnapshot.data}");
                    }
                  },
                ),
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

Future<Map<String, dynamic>> getPlantDataByIdInCloud(String id) async {
  List<Plant> _plantsList = await getPlantsListFuture();

  Map<String, dynamic>? _data;

  print("GIVEN ID: ${id}");

  _plantsList.forEach((element) {
    if (element.id == id) {
      _data = element.data;

      print("FOUND ID! ${element.name} IS THE PLANT! ${_data!.length} IS THE LENGTH, AND ${element.data} IS THE DATA");
    }
  });

  return _data!;
}