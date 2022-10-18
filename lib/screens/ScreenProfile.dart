import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/navigators/BottomTabNavigator.dart';
import 'package:socialchart/navigators/NavigationTree.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen")),
      body: Center(
          child: OutlinedButton(
              child: Text("Sign Out"),
              onPressed: () {
                IndexController.to.changeTabIndex(TabItem.home);
                AuthController.to.signOut();
              })),
    );
  }
}
