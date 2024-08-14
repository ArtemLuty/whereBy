import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whereby_app/core/app_theme.dart';

class RotatingProgressIndicator extends StatefulWidget {
  final Color? color;
  final double? strokeWidth;
  final double? size;

  const RotatingProgressIndicator({
    Key? key,
    this.size,
    this.color,
    this.strokeWidth,
  }) : super(key: key);

  @override
  State<RotatingProgressIndicator> createState() =>
      _RotatingProgressIndicatorState();
}

class _RotatingProgressIndicatorState extends State<RotatingProgressIndicator>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..repeat();

  @override
  void initState() {
    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() => setState(() {}));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? 36.sp;
    return SizedBox(
      width: size,
      height: size,
      child: Transform.rotate(
        angle: 2 * pi * _controller.value,
        child: CircularProgressIndicator(
          strokeWidth: widget.strokeWidth ?? 4.sp,
          color: widget.color ??
              AppTheme.invert(
                AppTheme.lightColors.primaryTextColor,
                AppTheme.darkColors.primaryTextColor,
              ),
        ),
      ),
    );
  }
}
