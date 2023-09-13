import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/TempData.dart';
import '../../utils/constants.dart';
import '../../utils/widget_functions.dart';
import '../BorderBoxButton.dart';
import '../UpdatedDataCard.dart';

class CardButton extends StatefulWidget {

  final Widget child;
  final VoidCallback onTap;
  final double? width, height;
  final EdgeInsets? padding;

  const CardButton({super.key, required this.child, required this.onTap, this.width, this.height, this.padding});

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);

    Size screenSize = MediaQuery.of(context).size;

    return BorderBoxButton(
      width: widget.width ?? screenSize.width - (screenSize.width / 2),
      height: widget.height ?? 50,
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: DARKMODE_ACTIVE ? COLOR_GREY.withAlpha(40) : COLOR_WHITE,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: DARKMODE_ACTIVE ? COLOR_GREY : COLOR_BLACK, width: 3),
      ),
      onTap: widget.onTap,
      child: widget.child,
    );
  }
}
