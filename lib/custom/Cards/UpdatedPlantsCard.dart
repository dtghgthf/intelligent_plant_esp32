import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/Cards/CardButton.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/screens/PlantOptionsPage.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';
import 'package:intelligent_plant_esp32/utils/widget_functions.dart';

import '../Objects/Plant.dart';

class UpdatedPlantsCard extends StatefulWidget {

  final Plant plant;

  const UpdatedPlantsCard({super.key, required this.plant});

  @override
  State<UpdatedPlantsCard> createState() => _UpdatedPlantsCardState();
}

class _UpdatedPlantsCardState extends State<UpdatedPlantsCard> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    return CardButton(
      width: size.width - 20,
      height: size.width - 20,
      padding: const EdgeInsets.all(10.0),
      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PlantOptionsPage(plant: widget.plant))); },
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              child: Image.asset("assets/images/NoImageIndicator.jpg"),
              borderRadius: BorderRadius.circular(25.0),
            )
          ),
          addVerticalSpace(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(widget.plant.name, style: themeData.textTheme.displayLarge),
                    addHorizontalSpace(5),
                    Text(widget.plant.species, style: themeData.textTheme.titleMedium),
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}
