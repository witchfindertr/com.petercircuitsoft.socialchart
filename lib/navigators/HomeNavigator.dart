import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/screens/ScreenHome.dart';

abstract class homeNavigatorRoute {
  static const ScreenHome = '/ScreenHome';
}

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      '/': (context) => ScreenHome(),
      '/ScreenHome': (context) => ScreenHome(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/ScreenHome',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilder[settings.name!]!(context));
      }),
    );
  }
}
