import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/customWidgets/UserInteredtedChart.dart';
import 'package:socialchart/customWidgets/UserProfileHeader.dart';
import 'package:socialchart/customWidgets/UserProfileInfo.dart';
import 'package:socialchart/navigators/BottomTabNavigator.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(children: [
          UserProfileHeader(),
          UserProfileInfo(),
          Divider(),
          UserInterestedChart(userInterestedCharts: ["a", "b", "c", "d"]),
        ]),
      ),
      // OutlinedButton(
      //   child: Text("Sign Out"),
      //   onPressed: () {
      //     IndexController.to.changeTabIndex(TabItem.home);
      //     AuthController.to.signOut();
      //   },
      // ),
    );
  }
}
