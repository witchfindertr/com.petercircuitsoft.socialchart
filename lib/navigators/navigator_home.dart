import 'package:flutter/material.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_binding.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_profile/ScreenProfile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/ScreenProfileBinding.dart';
import 'package:socialchart/screens/screen_write/screen_write.dart';
import 'package:socialchart/screens/screen_write/screen_write_binding.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.home.index),
      initialRoute: ScreenHome.routeName,
      onGenerateRoute: ((settings) {
        switch (settings.name) {
          case ScreenHome.routeName:
            return GetPageRoute(
              page: () => ScreenHome(navKey: NavKeys.home),
            );
          case ScreenInsightCard.routeName:
            return GetPageRoute(
                page: () => ScreenInsightCard(navKey: NavKeys.home));
          case ScreenProfile.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              page: () =>
                  ScreenProfile(userId: args.toString(), navKey: NavKeys.home),
              binding: ScreenProfileBinding(navKey: NavKeys.home),
            );
          case ScreenChart.routeName:
            return GetPageRoute(
              page: () => ScreenChart(navKey: NavKeys.home),
              binding: ScreenChartBinding(navKey: NavKeys.home),
            );
          case ScreenWrite.routeName:
            return GetPageRoute(
              page: () => ScreenWrite(navKey: NavKeys.home),
              binding: ScreenWriteBinding(navKey: NavKeys.home),
            );
          default:
            return null;
        }
        // });
      }),
    );
  }
}
