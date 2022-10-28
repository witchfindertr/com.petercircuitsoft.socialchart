import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/controllers/userProfileController.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:socialchart/screens/ScreenHome.dart';
import 'package:socialchart/screens/ScreenInsightCard.dart';
import 'package:socialchart/screens/ScreenProfile.dart';
import 'package:get/get.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(4),
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case '/':
            return GetPageRoute(
              settings: settings,
              page: () => ScreenProfile(),
              binding: UserProfileBinding(),
            );
            break;
          case ScreenProfile.routeName:
            return GetPageRoute(
              settings: settings,
              page: () => ScreenProfile(),
              binding: UserProfileBinding(),
            );
            break;
          default:
            return GetPageRoute(page: () => ScreenProfile());
        }
        // });
      }),
    );
  }
}

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily inject the dependency and only use the dependency when needed.
    Get.lazyPut(() => UserProfileController(), tag: "AuthProfile");
  }
}
