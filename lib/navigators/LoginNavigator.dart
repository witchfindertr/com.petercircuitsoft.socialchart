import 'package:flutter/material.dart';
import 'package:socialchart/navigators/NavigationTree.dart';
import 'package:socialchart/screens/ScreenLogin.dart';
import 'package:socialchart/screens/ScreenSignin.dart';

class LoginNavigator extends StatelessWidget {
  const LoginNavigator({super.key});
  // final List<ScreenRoute> routes;
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return Map.fromEntries(
        loginRoutes.map((e) => MapEntry(e.path, (context) => e.screen)));
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/ScreenLogin',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilder[settings.name!]!(context));
      }),
    );
  }
}
