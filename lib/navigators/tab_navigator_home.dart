import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main.dart';
import 'package:socialchart/navigators/tab_navigator_observer.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_binding.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_home/screen_home_binding.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_binding.dart';

class TabNavigatorHome extends StatelessWidget {
  const TabNavigatorHome({super.key, required this.observer});
  final NavigatorObserver observer;
  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(TabNavigatorHomeController());
    return Navigator(
      key: Get.nestedKey(NavKeys.home.index),
      initialRoute: ScreenHome.routeName,
      observers: [observer],
      onGenerateRoute: ((settings) {
        // print(RegExp(r"(\/)+([a-z,A-Z])\w+").firstMatch(settings.name!)?[0] ??
        //     "/");
        switch (settings.name) {
          case ScreenHome.routeName:
            return GetPageRoute(
              routeName: ScreenHome.routeName,
              page: () => ScreenHome(navKey: NavKeys.home),
              binding: ScreenHomeBinding(navKey: NavKeys.home),
              settings: settings,
            );
          case ScreenInsightCard.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              routeName: ScreenInsightCard.routeName,
              page: () => ScreenInsightCard(navKey: NavKeys.home),
              binding: ScreenInsightCardBinding(
                cardId: args.toString(),
                navKey: NavKeys.home,
              ),
              settings: settings,
            );
          case ScreenProfile.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              routeName: ScreenProfile.routeName,
              page: () =>
                  ScreenProfile(navKey: NavKeys.home, userId: args.toString()),
              binding: ScreenProfileBinding(
                  navKey: NavKeys.home, userId: args.toString()),
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
          // case ScreenWrite.routeName:
          //   var chartId = settings.arguments as String;
          //   return GetPageRoute(
          //     routeName: ScreenWrite.routeName,
          //     page: () => ScreenWrite(
          //       navKey: NavKeys.home,
          //     ),
          //     binding:
          //         ScreenWriteBinding(navKey: NavKeys.home, chartId: chartId),
          //     settings: settings,
          //   );
          default:
            return null;
        }
        // });
      }),
    );
  }
}
