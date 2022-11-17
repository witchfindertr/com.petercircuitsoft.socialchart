import 'dart:async';

import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';

class TabNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>?> _history = <Route<dynamic>?>[];

  BuiltList<Route<dynamic>> get history =>
      BuiltList<Route<dynamic>>.from(_history);

  Route<dynamic>? get top => _history.last;

  String? get currentRouteName => _history.last?.settings.name;

  final StreamController _historyChangeStreamController =
      StreamController.broadcast();

  Stream<dynamic> get historyChangeStream =>
      _historyChangeStreamController.stream;

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    _history.removeLast();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    _history.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
    _history.remove(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // TODO: implement didReplace
    int oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
    // super.didReplace(newRoute, oldRoute);
  }
}
