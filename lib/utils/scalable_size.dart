import 'package:flutter/material.dart';

extension ScalableSize on BuildContext {
  static double designHeight = 809;
  static double designWidth = 390;

  double getScalableHeight(double givenHeight) =>
      MediaQuery.of(this).size.height /
      _getProportionalCoefficient(designHeight, givenHeight);

  double getScalableWidth(double givenWidth) =>
      MediaQuery.of(this).size.width /
      _getProportionalCoefficient(designWidth, givenWidth);

  double _getProportionalCoefficient(double a, double b) => a / b;

  double getFontSize([double givenFontSize = 14]) =>
      MediaQuery.of(this).size.width < 600
          ? givenFontSize
          : givenFontSize * 1.5;
}
