import 'package:intelligent_plant_esp32/custom/Objects/Plant.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

const bool SAFEAREA_ACTIVE = true;
bool DARKMODE_ACTIVE = false;

List<Plant> Plants = [
  Plant(name: "Firebone", species: PLANT_SPECIES.Bean),
  Plant(name: "Tomato", species: PLANT_SPECIES.Tomato),
  Plant(name: "Cactus", species: PLANT_SPECIES.Cactus)
];