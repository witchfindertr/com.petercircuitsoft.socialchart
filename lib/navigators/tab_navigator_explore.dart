import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_explore/screen_explore.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_notice/screen_notice.dart';
import 'package:get/get.dart';

class TabNavigatorExplore extends StatelessWidget {
  const TabNavigatorExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.explore.index),
      initialRoute: ScreenNotice.routeName,
      onGenerateRoute: ((settings) {
        switch (settings.name) {
          case ScreenNotice.routeName:
            return GetPageRoute(
              page: () => ScreenExplore(navKey: NavKeys.explore),
              settings: settings,
            );

          case ScreenInsightCard.routeName:
            return GetPageRoute(
              page: () => ScreenInsightCard(navKey: NavKeys.explore),
              settings: settings,
            );

          default:
            return null;
        }
      }),
    );
  }
}
