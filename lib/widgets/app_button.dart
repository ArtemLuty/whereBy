import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whereby_app/core/app_theme.dart';
import 'package:whereby_app/widgets/rotating_progress_indicator.dart';
import 'package:whereby_app/widgets/svg_icon.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final String text;
  final String? icon;
  final bool filled;
  final double? circular;
  final bool? isLoading;
  final double? height;
  final double? width;
  final bool disabled;
  final Color? textColor;
  final double? elevation;
  final Color? borderColor;
  final void Function() onTap;

  const AppButton(
    this.text, {
    required this.onTap,
    this.color,
    this.height,
    this.width,
    this.circular,
    this.textColor,
    this.borderColor,
    this.filled = true,
    this.elevation = 0,
    this.isLoading,
    this.disabled = false,
    Key? key,
    this.icon,
  }) : super(key: key);

  Color get _backgroundColor {
    if (disabled) return AppTheme.colors.disabledColor;
    return color ?? AppTheme.colors.primaryButtonColor;
  }

  Color get _textColor {
    if (disabled) return AppTheme.colors.inActiveTextColor;

    if (filled) {
      return textColor ??
          AppTheme.invert(
            AppTheme.lightColors.primaryTextColor,
            AppTheme.darkColors.primaryTextColor,
          );
    }
    return textColor ?? AppTheme.colors.primaryTextColor;
  }

  Color get _borderColor {
    if (disabled) return AppTheme.colors.inActiveTextColor;
    return borderColor ?? AppTheme.colors.primaryButtonColor;
  }

  void _handleTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (isLoading == null || !isLoading!) onTap.call();
  }

  Tween<double> _getTween() {
    if (isLoading == null) return Tween<double>(begin: 0, end: 0);
    if (isLoading!) return Tween<double>(begin: 0, end: 1);
    return Tween<double>(begin: 1, end: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? 148.h,
      child: ElevatedButton(
        onPressed: !disabled ? () => _handleTap(context) : null,
        style: filled
            ? ButtonStyle(
                elevation: WidgetStateProperty.all<double?>(elevation),
                backgroundColor:
                    WidgetStateProperty.all<Color>(_backgroundColor),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(circular ?? 30.0),
                  ),
                ),
              )
            : ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circular ?? 30),
                ),
                side: BorderSide(
                  width: 1.w,
                  color: _borderColor,
                ),
              ).merge(
                ButtonStyle(
                  elevation: WidgetStateProperty.all<double?>(elevation),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    color ?? AppTheme.colors.primaryBgColor,
                  ),
                ),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgIcon(icon!, height: 18.h),
              SizedBox(width: 5.w)
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                color: _textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: _getTween(),
              duration: const Duration(milliseconds: 200),
              builder: (content, value, _) {
                if (value == 0) return Container();

                return Opacity(
                  opacity: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w * value),
                    child: RotatingProgressIndicator(
                      strokeWidth: 1.2.sp,
                      size: 18.sp * value,
                      color: AppTheme.isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
