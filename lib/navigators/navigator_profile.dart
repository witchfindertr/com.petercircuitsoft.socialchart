import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/navigators/navigator_constant.dart';
import 'package:socialchart/screens/screen_profile/ScreenProfile.dart';
import 'package:get/get.dart';
import 'package:socialchart/screens/screen_profile/ScreenProfileBinding.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

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
                userId: FirebaseAuth.instance.currentUser!.uid,
                navKey: NavKeys.profile,
              ),
              binding: ScreenProfileBinding(navKey: NavKeys.profile),
            );
            break;
          default:
            return GetPageRoute(
              page: () => ScreenProfile(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  navKey: NavKeys.profile),
              binding: ScreenProfileBinding(navKey: NavKeys.profile),
            );
        }
        // });
      }),
    );
  }
}
