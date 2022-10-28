import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:socialchart/screens/ScreenLogin.dart';
import 'package:socialchart/screens/ScreenCreateAccount.dart';

class LoginNavigator extends StatelessWidget {
  const LoginNavigator({super.key});
  // final List<ScreenRoute> routes;
  Map<String, Widget> _routeBuilder(BuildContext context) {
    return Map.fromEntries(
        loginRoutes.map((route) => MapEntry(route.path, route.screen)));
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/ScreenLogin',
      onGenerateRoute: ((settings) {
        return GetPageRoute(page: () => routeBuilder[settings.name]!);
        // return MaterialPageRoute(
        //     builder: (context) => routeBuilder[settings.name]!);
      }),
    );
  }
}
