import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';

import '../custom/Objects/Plant.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<List<Plant>> getPlantsListFuture() async {

  List<Plant> plants = [];
  int plantsCount = 0;

  CollectionReference plantsCollection = FirebaseFirestore.instance.collection('Users/${_auth.currentUser!.uid}/Plants');

  plantsCount = await countFieldsInCollection(plantsCollection.path);

  if (plantsCount == 0) {
    print("No Data in ${plantsCollection.path}");
    return [];
  }

  for (int i = 0; i < plantsCount; i++) {
    DocumentSnapshot data = await plantsCollection.doc("plant_$i").get();

    Plant _plant = Plant(name: data["Name"] ?? "", id: data["Id"] ?? "", species: PLANT_SPECIES.values.byName(data["Species"]), imageURL: data["ImageURL"] ?? "assets/images/NoImageIndicator.jpg", data: data["data"] ?? "");

    plants.add(_plant);
  }

  return plants;
}