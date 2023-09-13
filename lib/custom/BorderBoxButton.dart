import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

class BorderBoxButton extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;
  final double width, height;
  final Decoration? decoration;
  final VoidCallback? onTap;

  const BorderBoxButton({super.key, this.padding = const EdgeInsets.all(8.0), required this.width, required this.height, required this.child, this.onTap, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: decoration ?? BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withAlpha(40), width: 2),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
