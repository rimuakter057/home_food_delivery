import 'package:flutter/material.dart';

/// Scales raw design values (spacing, font size, icon size, radius) against
/// a reference mobile design width, clamped so layouts never shrink or grow
/// past a usable range on very small or very large screens.
class ResponsiveHelper {
  ResponsiveHelper(this.context);

  final BuildContext context;

  static const double _referenceWidth = 375.0;
  static const double _minScale = 0.82;
  static const double _maxScale = 1.35;

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  double get scaleFactor {
    final factor = screenWidth / _referenceWidth;
    return factor.clamp(_minScale, _maxScale);
  }

  double spacing(double value) => value * scaleFactor;

  double fontSize(double value) => value * scaleFactor;

  double iconSize(double value) => value * scaleFactor;

  double radius(double value) => value * scaleFactor;

  double size(double value) => value * scaleFactor;

  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) return EdgeInsets.all(spacing(all));
    return EdgeInsets.only(
      left: spacing(left ?? horizontal ?? 0),
      right: spacing(right ?? horizontal ?? 0),
      top: spacing(top ?? vertical ?? 0),
      bottom: spacing(bottom ?? vertical ?? 0),
    );
  }

  SizedBox verticalGap(double value) => SizedBox(height: spacing(value));

  SizedBox horizontalGap(double value) => SizedBox(width: spacing(value));
}

extension ResponsiveContextExtension on BuildContext {
  ResponsiveHelper get responsive => ResponsiveHelper(this);
}
