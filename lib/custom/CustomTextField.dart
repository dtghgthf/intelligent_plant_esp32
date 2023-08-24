import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/Cards/SettingsCard.dart';
import 'package:intelligent_plant_esp32/custom/UpdatedDataCard.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final double? width;
  final TextInputType keyboardType;

  CustomTextField({super.key, required this.text, required this.controller, this.width, this.keyboardType = TextInputType.text});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool showText = false;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return UpdatedDataCard(
      width: widget.width ?? screenSize.width - (screenSize.width / 5),
      height: 70,
      child: TextFormField(
        style: themeData.textTheme.labelLarge,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.text,
          suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
            icon: Icon(showText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                showText = !showText;
              });
            },
          ) : null
        ),
        cursorColor: COLOR_BLACK,
        obscureText: widget.keyboardType == TextInputType.visiblePassword && showText == false,
      ),
    );
  }
}
