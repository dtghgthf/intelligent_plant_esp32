import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/Cards/CardButton.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';
import 'package:intelligent_plant_esp32/utils/widget_functions.dart';

import '../Objects/Plant.dart';

class AddPlantCard extends StatefulWidget {

  final VoidCallback onTab;

  const AddPlantCard({super.key, required this.onTab});

  @override
  State<AddPlantCard> createState() => _AddPlantCardState();
}

class _AddPlantCardState extends State<AddPlantCard> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    return CardButton(
      width: size.width - 20,
      height: size.width - 20,
      padding: const EdgeInsets.all(10.0),
      onTap: widget.onTab,
      child: const Center(
        child: Icon(Icons.add)
      )
    );
  }
}
