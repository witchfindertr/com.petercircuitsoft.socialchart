import 'package:flutter/material.dart';
import 'package:socialchart/navigators/NavigationTree.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key, required this.routes});
  final List<ScreenRoute> routes;

  Map<String, Widget> _routeBuilder() {
    return Map.fromEntries(
        routes.map((route) => MapEntry(route.path, route.screen)));
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder();
    return Navigator(
      initialRoute: routes[0].path,
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(builder: (context) {
          return routeBuilder[settings.name]!;
        });
      }),
    );
  }
}
