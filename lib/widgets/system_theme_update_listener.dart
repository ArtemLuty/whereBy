import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereby_app/app/app_cubit.dart';

class SystemThemeUpdateListener extends StatefulWidget {
  final Widget child;
  const SystemThemeUpdateListener({super.key, required this.child});

  @override
  State<SystemThemeUpdateListener> createState() =>
      _SystemThemeUpdateListenerState();
}

class _SystemThemeUpdateListenerState extends State<SystemThemeUpdateListener>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        final cubit = context.read<AppCubit>();
        cubit.changeThemeMode(cubit.state.themeMode);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        final cubit = context.read<AppCubit>();
        cubit.changeThemeMode(cubit.state.themeMode);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
