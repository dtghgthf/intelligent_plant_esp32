import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

class Plant {
  final String id;
  final String name;
  final String species;
  final String imageURL;
  final Map<String, dynamic> data;/* = {
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
  };*/

  Plant({required this.name, required this.id, required this.species, required this.imageURL, required this.data});

  Map<String, dynamic> toJSON() {
    return {
      "Id": id,
      "Name": name,
      "Species": species,
      "ImageURL": imageURL,
      "data": data
    };
  }

  @override
  String toString() {
    return '{"id": $id, "name": $name, "species": ${species}, "imageURL": $imageURL, "data": $data}';
  }
}