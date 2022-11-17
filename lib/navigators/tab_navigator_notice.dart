import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_binding.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';
import 'package:socialchart/screens/screen_notice/screen_notice.dart';
import 'package:socialchart/screens/screen_notice/screen_notice_binding.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';

class TabNavigatorNotice extends StatelessWidget {
  const TabNavigatorNotice({super.key, required this.observer});
  final NavigatorObserver observer;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.notice.index),
      initialRoute: ScreenNotice.routeName,
      observers: [observer],
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case ScreenNotice.routeName:
            return GetPageRoute(
                settings: settings,
                page: () => ScreenNotice(navKey: NavKeys.notice),
                binding: ScreenNoticeBinding(navKey: NavKeys.notice));
            break;
          case ScreenInsightCard.routeName:
            var argc = settings.arguments;
            return GetPageRoute(
                settings: settings,
                page: () => ScreenInsightCard(navKey: NavKeys.notice),
                binding: ScreenInsightCardBinding(
                    navKey: NavKeys.notice, cardId: argc.toString()));
            break;
          default:
            return null;
        }
        // });
      }),
    );
  }
}
