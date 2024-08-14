// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whereby_app/modules/home_module/home_screen.dart';
import 'package:whereby_app/utils/screen_transitions.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes = {
    HomeScreen.path: (context) => HomeScreen(),
  };

  static Route onGenerateRoute(RouteSettings settings) {
    return CustomCupertinoRoute(
      settings: settings,
      builder: (context) => routes[settings.name]!(context),
    );
  }
}
