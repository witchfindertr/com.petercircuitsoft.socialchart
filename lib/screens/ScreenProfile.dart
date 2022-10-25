import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/authController.dart';
import 'package:socialchart/customWidgets/InsightCard/InsightCard.dart';
import 'package:socialchart/customWidgets/UserInteredtedChart.dart';
import 'package:socialchart/customWidgets/UserProfileHeader.dart';
import 'package:socialchart/customWidgets/UserProfileInfo.dart';
import 'package:socialchart/navigators/BottomTabNavigator.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:timeago/timeago.dart' as timeago;

List<int> test = [1, 2, 3, 4, 5, 6, 7];

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
          child: ListView.builder(
            itemCount: test.length + 3,
            itemBuilder: ((context, index) {
              switch (index) {
                case 0:
                  return UserProfileHeader();
                  break;
                case 1:
                  return UserProfileInfo();
                  break;
                case 2:
                  return UserInterestedChart(
                      userInterestedCharts: ["a", "b", "c", "d"]);
                  break;

                default:
                  return InsightCard();
                  break;
              }
            }),
          ),
        ));
  }
}
