import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';

import '../utils/constants.dart';

class UpdatedDataCard extends StatefulWidget {

  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const UpdatedDataCard({super.key, this.padding = const EdgeInsets.all(8.0), required this.width, required this.height, required this.child});

  @override
  State<UpdatedDataCard> createState() => _UpdatedDataCardState();
}

class _UpdatedDataCardState extends State<UpdatedDataCard> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: DARKMODE_ACTIVE ? COLOR_GREY.withAlpha(40) : COLOR_WHITE,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: DARKMODE_ACTIVE ? COLOR_WHITE.withAlpha(99) : COLOR_BLACK, width: 3),
      ),
      child: widget.child,
    );
  }
}
