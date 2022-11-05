import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:socialchart/custom_widgets/main_appbar.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home_controller.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/insightcard/insightcard.dart';

List<int> test = [1, 2, 3, 4, 5, 6, 7];

TextStyle appBarTitle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  foreground: Paint()
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.pinkAccent,
        Colors.deepPurpleAccent,
        Colors.red
        //add more color here.
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
    ),
);

class ScreenHome extends GetView<ScreenHomeController> {
  const ScreenHome({super.key, this.navKey});
  final NavKeys? navKey;
  static const routeName = '/ScreenHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), title: "Social Chart"),
      body: Container(
        color: Colors.black12,
        child: Obx(
          () => ListView.builder(
            itemCount: controller.insightCards.length,
            itemBuilder: (context, index) {
              return InsightCard(
                navKey: navKey,
                cardInfo: controller.insightCards[index].data(),
              );
            },
          ),
        ),
      ),
    );
  }
}
