import 'package:flutter/material.dart';

import '../../injection.dart';

class Navigation {
  static void intentWithData(String routeName, Object arguments) {
    getIt<GlobalKey<NavigatorState>>()
        .currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  static void back() => getIt<GlobalKey<NavigatorState>>().currentState?.pop();
}
