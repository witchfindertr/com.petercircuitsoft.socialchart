import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_binding.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_home/screen_home_binding.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_binding.dart';
import 'package:socialchart/screens/screen_test/page_test.dart';
import 'package:socialchart/screens/screen_test/page_test_binding.dart';
import 'package:socialchart/screens/screen_write/screen_write.dart';
import 'package:socialchart/screens/screen_write/screen_write_binding.dart';

class TabNavigatorHome extends StatelessWidget {
  const TabNavigatorHome({super.key});

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
              binding: ScreenHomeBinding(navKey: NavKeys.home),
            );
          case ScreenInsightCard.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              page: () => ScreenInsightCard(navKey: NavKeys.home),
              binding: ScreenInsightCardBinding(
                  cardId: args.toString(), navKey: NavKeys.home),
            );
          case ScreenProfile.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              page: () => ScreenProfile(navKey: NavKeys.home),
              binding: ScreenProfileBinding(
                  navKey: NavKeys.home, userId: args.toString()),
            );
          case ScreenChart.routeName:
            return GetPageRoute(
              page: () => ScreenChart(navKey: NavKeys.home),
              binding: ScreenChartBinding(navKey: NavKeys.home),
            );
          case ScreenWrite.routeName:
            var chartId = settings.arguments as String;
            return GetPageRoute(
              page: () => ScreenWrite(
                navKey: NavKeys.home,
              ),
              binding:
                  ScreenWriteBinding(navKey: NavKeys.home, chartId: chartId),
            );
          // case PageTest.routeName:
          //   return GetPageRoute(
          //     page: () => PageTest(controllerTag: "홈"),
          //     binding: PageTestBinding(controllerTag: "홈"),
          //   );
          default:
            return null;
        }
        // });
      }),
    );
  }
}
