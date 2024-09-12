import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whereby_app/core/app_bloc.dart';
import 'package:whereby_app/widgets/splash_lifecycle_overlay.dart';
import 'package:whereby_app/widgets/splash_screen.dart';

import 'core/app_locale.dart';

class SetupApp extends StatefulWidget {
  final Widget Function(BuildContext) builder;

  const SetupApp({required this.builder, Key? key}) : super(key: key);

  @override
  _SetupAppState createState() => _SetupAppState();
}

class _SetupAppState extends State<SetupApp> {
  final Future<void> _setupFuture = _setup();

  @override
  void dispose() {
    super.dispose();
  }

  static Future<void> _setup() async {
    AppBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return AppLocale.localizeApp(
      app: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (_, __) {
          return FutureBuilder(
            future: _setupFuture,
            builder: (context, snapshot) {
              Intl.defaultLocale = context.locale.languageCode;
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              }
              return SplashLifecycleOverlay(
                splashBuilder: (_) => const SplashScreen(),
                child: AppBloc.appBuilder(widget.builder),
              );
            },
          );
        },
      ),
    );
  }
}
