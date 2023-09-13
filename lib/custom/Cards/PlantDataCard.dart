import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../screens/PlantOptionsPage.dart';
import '../Objects/Plant.dart';

class PlantDataCard extends StatefulWidget {
  final Plant plant;
  final double? width, height;
  final DATA_TYPES dataType;

  const PlantDataCard({super.key, this.width, this.height, required this.plant, required this.dataType});

  @override
  State<PlantDataCard> createState() => _PlantDataCardState();
}

List<LightData> _lightData = [];
List<TemperatureData> _tempData = [];
List<WaterData> _waterData = [];

final FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference _plantsCollection = FirebaseFirestore.instance.collection('Users/${_auth.currentUser!.uid}/Plants');

CircularSeriesController? _circularSeriesController;

class _PlantDataCardState extends State<PlantDataCard> {

  @override
  void initState() {
    _plantsCollection.snapshots().listen((event) {
      print("UPDATE!");

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return FutureBuilder(
      future: getPlantDataByIdInCloud(widget.plant.id),
      builder: (context, FutureSnapshot) {
        if (FutureSnapshot.hasData) {

          print(FutureSnapshot.data!["Light"]["inLux"]);
          print(FutureSnapshot.data!["Light"]["inPercent"]);

          _lightData = [
            LightData(LIGHT_DATA_TYPE.inPercent, FutureSnapshot.data!["Light"]["inPercent"]),
            LightData(LIGHT_DATA_TYPE.inLux, FutureSnapshot.data!["Light"]["inLux"])
          ];

          _tempData = [
            TemperatureData(TEMP_DATA_TYPE.inPercent, FutureSnapshot.data!["Temperature"]["inPercent"]),
            TemperatureData(TEMP_DATA_TYPE.inC, FutureSnapshot.data!["Temperature"]["in°C"]),
            TemperatureData(TEMP_DATA_TYPE.inF, FutureSnapshot.data!["Temperature"]["in°F"]),
          ];

          _waterData = [
            WaterData(FutureSnapshot.data!["Water"]["inPercent"])
          ];

          return UpdatedDataCard(
              width: widget.width ?? size.width - (size.width / 1.8),
              height: widget.height ?? size.width - (size.width / 1.8),
              child: SfCircularChart(
                series: <CircularSeries> [
                  radialBarSeriesByDataType(widget.dataType, themeData)
                ],
              )
          );
        } else if (FutureSnapshot.hasError) {
          return Text("ERROR: ${FutureSnapshot.error}");
        } else if (!FutureSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Text("${FutureSnapshot.data}");
        }
      },
    );
  }
}

RadialBarSeries radialBarSeriesByDataType(DATA_TYPES type, ThemeData themeData) {

  if (type == DATA_TYPES.Light) {
    return RadialBarSeries<LightData, String>(
      onRendererCreated: (controller) {
        _circularSeriesController = controller;
      },
      cornerStyle: CornerStyle.bothCurve,
      dataSource: _lightData,
      xValueMapper: (LightData data, _) => data.dataType.toString(),
      yValueMapper: (LightData data, _) => data.dataValue,
      innerRadius: "20",
      maximumValue: 100,
      dataLabelMapper: (data, value) {
        return "${data.dataType.name}: ${data.dataValue}";
      },
      dataLabelSettings: DataLabelSettings(
        isVisible: true,
        textStyle: themeData.textTheme.labelMedium,
      ),
    );
  } else if (type == DATA_TYPES.Temperature) {
    return RadialBarSeries<TemperatureData, String>(
      onRendererCreated: (controller) {
        _circularSeriesController = controller;
      },
      cornerStyle: CornerStyle.bothCurve,
      dataSource: _tempData,
      xValueMapper: (TemperatureData data, _) => data.dataType.toString(),
      yValueMapper: (TemperatureData data, _) => data.dataValue,
      innerRadius: "20",
      dataLabelMapper: (data, value) {
        return "${data.dataType.name}: ${data.dataValue}";
      },
      dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: themeData.textTheme.labelMedium
      ),
    );
  } else if (type == DATA_TYPES.Water) {
    return RadialBarSeries<WaterData, String>(
      onRendererCreated: (controller) {
        _circularSeriesController = controller;
      },
      dataSource: _waterData,
      cornerStyle: _waterData[0].dataValue <= 25 ? CornerStyle.endCurve : CornerStyle.bothCurve,
      xValueMapper: (WaterData data, _) => "In %",
      yValueMapper: (WaterData data, _) => data.dataValue,
      maximumValue: 100,
      dataLabelMapper: (data, value) {
        return "inPercent: ${data.dataValue}";
      },
      dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: themeData.textTheme.labelMedium
      ),
    );
  } else {
    return RadialBarSeries<LightData, String>(
      onRendererCreated: (controller) {
        _circularSeriesController = controller;
      },
      dataSource: null,
      xValueMapper: (LightData data, _) => "ERROR",
      yValueMapper: (LightData data, _) => 404,
    );
  }

}

class LightData {
  final LIGHT_DATA_TYPE dataType;
  final dynamic dataValue;

  LightData(this.dataType, this.dataValue);
}
class TemperatureData {
  final TEMP_DATA_TYPE dataType;
  final dynamic dataValue;

  TemperatureData(this.dataType, this.dataValue);
}
class WaterData {
  final dynamic dataValue;

  WaterData(this.dataValue);
}