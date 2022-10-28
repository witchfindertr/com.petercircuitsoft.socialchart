import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchart/controllers/userProfileController.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:socialchart/screens/ScreenHome.dart';
import 'package:socialchart/screens/ScreenInsightCard.dart';
import 'package:socialchart/screens/ScreenProfile.dart';
import 'package:get/get.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1),
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        // return MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case '/':
            return GetPageRoute(page: () => ScreenHome());
            break;
          case ScreenHome.routeName:
            return GetPageRoute(page: () => ScreenHome());
            break;
          case ScreenInsightCard.routeName:
            return GetPageRoute(page: () => ScreenInsightCard());
            break;
          case ScreenProfile.routeName:
            var args = settings.arguments as ScreenProfileArgs?;
            print("args: ${args}");
            return GetPageRoute(
              page: () => ScreenProfile(userId: args!.userId),
              parameter: {"args": "asdf"},
              binding: BindingsBuilder(
                () => Get.lazyPut<UserProfileController>(
                    () => UserProfileController(),
                    tag: "UserProfile"),
              ),
            );
            break;
          default:
            return GetPageRoute(page: () => ScreenHome());
        }
        // });
      }),
    );
  }
}
