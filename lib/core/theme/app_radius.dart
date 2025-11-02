// lib/theme/app_radius.dart

import 'package:flutter/material.dart';

/// Defines the corner radius scale based on Material 3 shape system.
/// Each style corresponds to a specific amount of roundedness.
class AppRadius {
  AppRadius._(); // private constructor to prevent instantiation

  static const none = Radius.circular(0);
  static const extraSmall = Radius.circular(4);
  static const small = Radius.circular(8);
  static const medium = Radius.circular(12);
  static const large = Radius.circular(16);
  static const largeIncreased = Radius.circular(20);
  static const extraLarge = Radius.circular(28);
  static const extraLargeIncreased = Radius.circular(32);
  static const extraExtraLarge = Radius.circular(48);
  static const full = Radius.circular(
    1000,
  ); // or use BorderRadius.circular(9999)
}

/// You can also create BorderRadius presets for convenience.
class AppBorderRadius {
  AppBorderRadius._();

  static const none = BorderRadius.all(AppRadius.none);
  static const extraSmall = BorderRadius.all(AppRadius.extraSmall);
  static const small = BorderRadius.all(AppRadius.small);
  static const medium = BorderRadius.all(AppRadius.medium);
  static const large = BorderRadius.all(AppRadius.large);
  static const largeIncreased = BorderRadius.all(AppRadius.largeIncreased);
  static const extraLarge = BorderRadius.all(AppRadius.extraLarge);
  static const extraLargeIncreased = BorderRadius.all(
    AppRadius.extraLargeIncreased,
  );
  static const extraExtraLarge = BorderRadius.all(AppRadius.extraExtraLarge);
  static const full = BorderRadius.all(AppRadius.full);
}
