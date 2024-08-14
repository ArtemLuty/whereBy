import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoRoute<T> extends PageRouteBuilder<T>
    with CupertinoRouteTransitionMixin {
  final WidgetBuilder builder;

  @override
  final String? title;

  @override
  final RouteSettings settings;

  CustomCupertinoRoute({
    this.title,
    required this.builder,
    this.settings = const RouteSettings(),
  }) : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, _, __) => builder(context),
        );

  @override
  Color get barrierColor => Colors.transparent;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 650);
}

Route<T> slideUpTransition<T>(
  WidgetBuilder screenBuilder, {
  RouteSettings? settings,
}) {
  return PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, __, ___) => screenBuilder(context),
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
