import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/TempData.dart';
import '../../utils/widget_functions.dart';
import '../UpdatedDataCard.dart';

class SettingsCard extends StatefulWidget {

  final Widget child;

  const SettingsCard({super.key, required this.child});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);

    Size screenSize = window.physicalSize;

    return UpdatedDataCard(
        width: screenSize.width,
        height: 50,
        child: widget.child
    );
  }
}
