import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main.dart';
import 'package:socialchart/navigators/tab_navigator_observer.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting_binding.dart';
import 'package:socialchart/screens/screen_account_setting/screen_account_setting_controller.dart';
import 'package:socialchart/screens/screen_chart/screen_chart.dart';
import 'package:socialchart/screens/screen_chart/screen_chart_binding.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_binding.dart';
import 'package:socialchart/screens/screen_test/page_test.dart';
import 'package:socialchart/screens/screen_test/page_test_binding.dart';

class TabNavigatorProfile extends StatelessWidget {
  const TabNavigatorProfile({super.key, required this.observer});
  final NavigatorObserver observer;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.profile.index),
      initialRoute: ScreenProfile.routeName,
      observers: [observer],
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case ScreenProfile.routeName:
            return GetPageRoute(
              settings: settings,
              page: () => ScreenProfile(
                navKey: NavKeys.profile,
              ),
              binding: ScreenProfileBinding(
                navKey: NavKeys.profile,
                userId: firebaseAuth.currentUser!.uid,
              ),
            );
            break;
          case ScreenInsightCard.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              routeName: ScreenInsightCard.routeName,
              page: () => ScreenInsightCard(navKey: NavKeys.profile),
              binding: ScreenInsightCardBinding(
                cardId: args.toString(),
                navKey: NavKeys.profile,
              ),
              settings: settings,
            );
          case ScreenChart.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              routeName: ScreenChart.routeName,
              page: () => ScreenChart(navKey: NavKeys.profile),
              binding: ScreenChartBinding(
                  navKey: NavKeys.profile, chartId: args.toString()),
              settings: settings,
            );
          case ScreenAccountSetting.routeName:
            var args = settings.arguments;
            return GetPageRoute(
              page: () => ScreenAccountSetting(navKey: NavKeys.profile),
              binding: ScreenAccountSettingBinding(
                  navkey: NavKeys.profile, userData: args as ModelUserData),
              settings: settings,
            );
            break;
          default:
            return null;
        }
        // });
      }),
    );
  }
}
