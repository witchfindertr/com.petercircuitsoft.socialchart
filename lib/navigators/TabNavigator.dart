import 'package:flutter/material.dart';
import 'package:socialchart/navigators/NavigationTree.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({super.key, required this.routes});
  final List<ScreenRoute> routes;
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return Map.fromEntries(
        routes.map((e) => MapEntry(e.path, (context) => e.screen)));
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: routes[0].path,
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilder[settings.name!]!(context));
      }),
    );
  }
}
