import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

class Plant {
  final String name;
  final PLANT_SPECIES species;
  final Image? image;

  Plant({required this.name, this.species = PLANT_SPECIES.Unknown, this.image});
}