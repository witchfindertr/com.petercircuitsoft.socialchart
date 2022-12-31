import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_binding.dart';
import 'package:socialchart/screens/screen_explore/screen_explore.dart';
import 'package:socialchart/screens/screen_explore/screen_explore_binding.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_binding.dart';
import 'package:socialchart/screens/screen_notice/screen_notice.dart';
import 'package:get/get.dart';

class TabNavigatorExplore extends StatelessWidget {
  const TabNavigatorExplore({super.key, required this.observer});
  final NavigatorObserver observer;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.explore.index),
      initialRoute: ScreenExplore.routeName,
      observers: [observer],
      onGenerateRoute: ((settings) {
        switch (settings.name) {
          case ScreenExplore.routeName:
            return GetPageRoute(
              page: () => ScreenExplore(navKey: NavKeys.explore),
              binding: ScreenExploreBinding(navKey: NavKeys.explore),
              settings: settings,
            );

          case ScreenInsightCard.routeName:
            var argc = settings.arguments;
            return GetPageRoute(
              page: () => ScreenInsightCard(navKey: NavKeys.explore),
              binding: ScreenInsightCardBinding(
                  navKey: NavKeys.explore, cardId: argc.toString()),
              settings: settings,
            );
          case ScreenChart.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              routeName: ScreenChart.routeName,
              page: () => ScreenChart(navKey: NavKeys.home),
              binding: ScreenChartBinding(
                  navKey: NavKeys.home, chartId: args.toString()),
              settings: settings,
            );

          default:
            return null;
        }
      }),
    );
  }
}
