import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  final bool isStatic;

  const SplashScreen({this.isStatic = true, super.key});

  static Widget animated() {
    return const SplashScreen(isStatic: false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      child: const RiveAnimation.asset('assets/riv/pin-pong.riv',
          fit: BoxFit.cover),
    );
  }
}
