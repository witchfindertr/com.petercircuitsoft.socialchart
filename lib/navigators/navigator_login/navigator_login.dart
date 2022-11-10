import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/navigators/navigator_login/navigator_login_controller.dart';
import 'package:socialchart/screens/screen_login/screen_login.dart';
import 'package:socialchart/screens/screen_login/screen_login_binding.dart';
import 'package:socialchart/screens/screen_report/screen_report.dart';
import 'package:socialchart/screens/screen_report/screen_report_binding.dart';

class NavigatorLogin extends GetView<NavigatorLoginController> {
  const NavigatorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavKeys.login.index),
      initialRoute: ScreenLogin.routeName,
      onGenerateRoute: ((settings) {
        switch (settings.name) {
          case ScreenLogin.routeName:
            return GetPageRoute(
              page: () => ScreenLogin(navKey: NavKeys.login),
              binding: ScreenLoginBinding(navKey: NavKeys.login),
            );
          case ScreenReport.routeName:
            return GetPageRoute(
              page: () => ScreenReport(navKey: NavKeys.login),
              binding: ScreenReportBinding(navKey: NavKeys.login),
            );
          default:
            return null;
        }
      }),
    );
  }
}
