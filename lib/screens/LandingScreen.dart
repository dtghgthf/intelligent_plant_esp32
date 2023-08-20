import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/BorderBox.dart';
import 'package:intelligent_plant_esp32/custom/BorderBoxButton.dart';
import 'package:intelligent_plant_esp32/custom/Cards/UpdatedPlantsCard.dart';
import 'package:intelligent_plant_esp32/screens/SettingScreen.dart';
import 'package:intelligent_plant_esp32/utils/TempData.dart';
import 'package:intelligent_plant_esp32/utils/constants.dart';

import '../utils/widget_functions.dart';

class LandingScreen extends StatefulWidget {
  final VoidCallback updateTheme;

  const LandingScreen({super.key, required this.updateTheme});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

late TabController tabController;
final List<Widget> tabs = [
  /*TabOverlay(width: 150, height: 50, text: "Home"),
  TabOverlay(width: 150, height: 50, text: "Tab 2"),*/

  Tab(text: "Home", icon: Icon(Icons.home)),
  Tab(text: "Settings", icon: Icon(Icons.settings)),
];

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double padding = 25;
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              addVerticalSpace(padding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello, your plants are doing Great!", style: themeData.textTheme.headlineMedium),
                    BorderBoxButton(width: 50, height: 50, child: Icon(Icons.settings), onTap: () {
                      /*setState(() {
                        DARKMODE_ACTIVE = !DARKMODE_ACTIVE;
                      });
                      widget.updateTheme();*/

                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(updateTheme: widget.updateTheme)));
                    })
                  ],
                ),
              ),
              addVerticalSpace(10),
              Divider(color: COLOR_GREY.withAlpha(100), thickness: 2),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                      itemCount: Plants.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            addVerticalSpace(padding / 2),
                            UpdatedPlantsCard(plant: Plants[index]),
                            addVerticalSpace(padding)
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: Plants.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            addVerticalSpace(padding / 2),
                            UpdatedPlantsCard(plant: Plants[index]),
                            addVerticalSpace(padding)
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: 90,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: DARKMODE_ACTIVE ? [COLOR_BLACK.withAlpha(0), COLOR_GREY] : [COLOR_WHITE.withAlpha(10), COLOR_GREY],
                )
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            width: size.width,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: COLOR_DARK_BLUE,
              controller: tabController,
              tabs: tabs,
            )
          )
        ],
      ),
    );
  }
}

class TabOverlay extends StatelessWidget {
  final double width, height;
  final IconData? icon;
  final String text;

  const TabOverlay({super.key, required this.width, required this.height, this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: COLOR_DARK_BLUE,
        ),
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: icon != null ? Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon!, color: COLOR_WHITE),
              addHorizontalSpace(10),
              Text(text, style: TextStyle(color: COLOR_WHITE)),
            ],
          ),
        ) : Center(child: Text(text, style: TextStyle(color: COLOR_WHITE))),
      )
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffset =
        offset + Offset(configuration.size!.width / 2, configuration.size!.height - radius);

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}