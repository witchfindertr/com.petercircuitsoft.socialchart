import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socialchart/screens/ScreenExplore.dart';

abstract class exploreNavigatorRoute {
  static const ScreenRoot = '/';
  static const ScreenExplore = '/ScreenExplore';
}

class ExploreNavigator extends StatelessWidget {
  const ExploreNavigator({super.key});
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      '/': (context) => ScreenExplore(),
      '/ScreenExplore': (context) => ScreenExplore(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/ScreenExplore',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilder[settings.name!]!(context));
      }),
    );
  }
}
