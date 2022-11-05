import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/screens/screen_profile/screen_profile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/screen_profile_binding.dart';
import 'package:socialchart/screens/screen_test/page_test.dart';
import 'package:socialchart/screens/screen_test/page_test_binding.dart';

class TabNavigatorProfile extends StatelessWidget {
  const TabNavigatorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.profile.index),
      initialRoute: ScreenProfile.routeName,
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case ScreenProfile.routeName:
            return GetPageRoute(
              settings: settings,
              page: () => ScreenProfile(
                userId: firebaseAuth.currentUser!.uid,
                navKey: NavKeys.profile,
              ),
              binding: ScreenProfileBinding(navKey: NavKeys.profile),
            );
            break;
          case PageTest.routeName:
            return GetPageRoute(
              page: () => PageTest(controllerTag: "내정보"),
              binding: PageTestBinding(controllerTag: "내정보"),
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
