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

    Size screenSize = MediaQuery.of(context).size;

    return UpdatedDataCard(
        width: screenSize.width - (screenSize.width / 2),
        height: 60,
        child: widget.child
    );
  }
}
