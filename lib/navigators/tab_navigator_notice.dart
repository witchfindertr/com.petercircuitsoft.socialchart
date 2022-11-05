import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_home/screen_home.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard.dart';
import 'package:socialchart/screens/screen_notice/screen_notice.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';

class TabNavigatorNotice extends StatelessWidget {
  const TabNavigatorNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.notice.index),
      initialRoute: ScreenNotice.routeName,
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case ScreenNotice.routeName:
            return GetPageRoute(
                page: () => ScreenNotice(navKey: NavKeys.notice));
            break;
          case ScreenInsightCard.routeName:
            return GetPageRoute(
                page: () => ScreenInsightCard(navKey: NavKeys.notice));
            break;
          default:
            return null;
        }
        // });
      }),
    );
  }
}