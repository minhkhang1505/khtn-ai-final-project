import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff126684),
      surfaceTint: Color(0xff126684),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5a9fc0),
      onPrimaryContainer: Color(0xff003446),
      secondary: Color(0xff4a626f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcae3f3),
      onSecondaryContainer: Color(0xff4e6673),
      tertiary: Color(0xff006192),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff247bb1),
      onTertiaryContainer: Color(0xfffcfcff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff8f9fc),
      onSurface: Color(0xff191c1e),
      onSurfaceVariant: Color(0xff40484d),
      outline: Color(0xff70787e),
      outlineVariant: Color(0xffbfc8ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3133),
      inversePrimary: Color(0xff8bcff2),
      primaryFixed: Color(0xffc0e8ff),
      onPrimaryFixed: Color(0xff001e2b),
      primaryFixedDim: Color(0xff8bcff2),
      onPrimaryFixedVariant: Color(0xff004d66),
      secondaryFixed: Color(0xffcde6f6),
      onSecondaryFixed: Color(0xff031e29),
      secondaryFixedDim: Color(0xffb1cad9),
      onSecondaryFixedVariant: Color(0xff324a56),
      tertiaryFixed: Color(0xffcce6ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff90cdff),
      onTertiaryFixedVariant: Color(0xff004b72),
      surfaceDim: Color(0xffd8dadd),
      surfaceBright: Color(0xfff8f9fc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f6),
      surfaceContainer: Color(0xffeceef1),
      surfaceContainerHigh: Color(0xffe6e8eb),
      surfaceContainerHighest: Color(0xffe1e3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003b4f),
      surfaceTint: Color(0xff126684),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2a7594),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff213945),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff58707e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003a59),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1573a9),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9fc),
      onSurface: Color(0xff0e1214),
      onSurfaceVariant: Color(0xff2f373c),
      outline: Color(0xff4b5459),
      outlineVariant: Color(0xff666e74),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3133),
      inversePrimary: Color(0xff8bcff2),
      primaryFixed: Color(0xff2a7594),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005c79),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff58707e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff405865),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1573a9),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005a87),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c7c9),
      surfaceBright: Color(0xfff8f9fc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f6),
      surfaceContainer: Color(0xffe6e8eb),
      surfaceContainerHigh: Color(0xffdbdde0),
      surfaceContainerHighest: Color(0xffd0d2d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003042),
      surfaceTint: Color(0xff126684),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004f69),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff162f3b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff344c59),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002f4a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004d76),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9fc),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252d32),
      outlineVariant: Color(0xff424a4f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3133),
      inversePrimary: Color(0xff8bcff2),
      primaryFixed: Color(0xff004f69),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00374b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff344c59),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1d3642),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004d76),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003654),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6b9bc),
      surfaceBright: Color(0xfff8f9fc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff1f3),
      surfaceContainer: Color(0xffe1e3e5),
      surfaceContainerHigh: Color(0xffd2d5d7),
      surfaceContainerHighest: Color(0xffc4c7c9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bcff2),
      surfaceTint: Color(0xff8bcff2),
      onPrimary: Color(0xff003547),
      primaryContainer: Color(0xff5a9fc0),
      onPrimaryContainer: Color(0xff003446),
      secondary: Color(0xffb1cad9),
      onSecondary: Color(0xff1b333f),
      secondaryContainer: Color(0xff344c59),
      onSecondaryContainer: Color(0xffa3bccb),
      tertiary: Color(0xff90cdff),
      onTertiary: Color(0xff003350),
      tertiaryContainer: Color(0xff4997cf),
      onTertiaryContainer: Color(0xff002c46),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101416),
      onSurface: Color(0xffe1e3e5),
      onSurfaceVariant: Color(0xffbfc8ce),
      outline: Color(0xff899298),
      outlineVariant: Color(0xff40484d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e5),
      inversePrimary: Color(0xff126684),
      primaryFixed: Color(0xffc0e8ff),
      onPrimaryFixed: Color(0xff001e2b),
      primaryFixedDim: Color(0xff8bcff2),
      onPrimaryFixedVariant: Color(0xff004d66),
      secondaryFixed: Color(0xffcde6f6),
      onSecondaryFixed: Color(0xff031e29),
      secondaryFixedDim: Color(0xffb1cad9),
      onSecondaryFixedVariant: Color(0xff324a56),
      tertiaryFixed: Color(0xffcce6ff),
      onTertiaryFixed: Color(0xff001e31),
      tertiaryFixedDim: Color(0xff90cdff),
      onTertiaryFixedVariant: Color(0xff004b72),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff363a3c),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff191c1e),
      surfaceContainer: Color(0xff1d2022),
      surfaceContainerHigh: Color(0xff272a2d),
      surfaceContainerHighest: Color(0xff323537),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb1e3ff),
      surfaceTint: Color(0xff8bcff2),
      onPrimary: Color(0xff002939),
      primaryContainer: Color(0xff5a9fc0),
      onPrimaryContainer: Color(0xff000305),
      secondary: Color(0xffc6e0f0),
      onSecondary: Color(0xff0f2834),
      secondaryContainer: Color(0xff7c94a2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffbfe0ff),
      onTertiary: Color(0xff002840),
      tertiaryContainer: Color(0xff4997cf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dde4),
      outline: Color(0xffabb3b9),
      outlineVariant: Color(0xff899197),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e5),
      inversePrimary: Color(0xff004e68),
      primaryFixed: Color(0xffc0e8ff),
      onPrimaryFixed: Color(0xff00131d),
      primaryFixedDim: Color(0xff8bcff2),
      onPrimaryFixedVariant: Color(0xff003b4f),
      secondaryFixed: Color(0xffcde6f6),
      onSecondaryFixed: Color(0xff00131d),
      secondaryFixedDim: Color(0xffb1cad9),
      onSecondaryFixedVariant: Color(0xff213945),
      tertiaryFixed: Color(0xffcce6ff),
      onTertiaryFixed: Color(0xff001321),
      tertiaryFixedDim: Color(0xff90cdff),
      onTertiaryFixedVariant: Color(0xff003a59),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff424547),
      surfaceContainerLowest: Color(0xff05080a),
      surfaceContainerLow: Color(0xff1b1e20),
      surfaceContainer: Color(0xff25282a),
      surfaceContainerHigh: Color(0xff303335),
      surfaceContainerHighest: Color(0xff3b3e40),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe0f3ff),
      surfaceTint: Color(0xff8bcff2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff87cbee),
      onPrimaryContainer: Color(0xff000d14),
      secondary: Color(0xffe0f3ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffadc6d5),
      onSecondaryContainer: Color(0xff000d14),
      tertiary: Color(0xffe5f1ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff87c9ff),
      onTertiaryContainer: Color(0xff000c18),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff101416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f1f7),
      outlineVariant: Color(0xffbbc4ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e5),
      inversePrimary: Color(0xff004e68),
      primaryFixed: Color(0xffc0e8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8bcff2),
      onPrimaryFixedVariant: Color(0xff00131d),
      secondaryFixed: Color(0xffcde6f6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb1cad9),
      onSecondaryFixedVariant: Color(0xff00131d),
      tertiaryFixed: Color(0xffcce6ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff90cdff),
      onTertiaryFixedVariant: Color(0xff001321),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff4d5053),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2022),
      surfaceContainer: Color(0xff2e3133),
      surfaceContainerHigh: Color(0xff393c3e),
      surfaceContainerHighest: Color(0xff444749),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
