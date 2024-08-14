import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whereby_app/core/app_theme.dart';

class SvgIcon extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final String iconName;
  final BoxFit fit;
  final bool themed;

  const SvgIcon(
    this.iconName, {
    this.color,
    this.width,
    this.height,
    this.themed = false,
    this.fit = BoxFit.contain,
    Key? key,
  }) : super(key: key);

  const SvgIcon.themed(
    this.iconName, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  }) : themed = true;

  @override
  Widget build(BuildContext context) {
    final bool isDark = themed && AppTheme.isDarkMode;
    return SvgPicture.asset(
      'assets/svg/$iconName${isDark ? '--dark' : ''}.svg',
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
