import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff256a4b),
      surfaceTint: Color(0xff256a4b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffabf2ca),
      onPrimaryContainer: Color(0xff002113),
      secondary: Color(0xff6f5d0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffae287),
      onSecondaryContainer: Color(0xff221b00),
      tertiary: Color(0xff904a49),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad8),
      onTertiaryContainer: Color(0xff3b080c),
      error: Color(0xff904a45),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff3b0908),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffc0c8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff90d5ae),
      primaryFixed: Color(0xffabf2ca),
      onPrimaryFixed: Color(0xff002113),
      primaryFixedDim: Color(0xff90d5ae),
      onPrimaryFixedVariant: Color(0xff005234),
      secondaryFixed: Color(0xfffae287),
      onSecondaryFixed: Color(0xff221b00),
      secondaryFixedDim: Color(0xffddc66e),
      onSecondaryFixedVariant: Color(0xff544600),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff3b080c),
      tertiaryFixedDim: Color(0xffffb3b1),
      onTertiaryFixedVariant: Color(0xff733333),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004d31),
      surfaceTint: Color(0xff256a4b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3d8160),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff504200),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff867325),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff6e2f30),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaa5f5e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff6e302b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffaa6059),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3c4448),
      outline: Color(0xff586064),
      outlineVariant: Color(0xff747c80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xff90d5ae),
      primaryFixed: Color(0xff3d8160),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff226848),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff867325),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6c5b0b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffaa5f5e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff8d4747),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002818),
      surfaceTint: Color(0xff256a4b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004d31),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2a2200),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff504200),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff440f12),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6e2f30),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff44100e),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e302b),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1d2529),
      outline: Color(0xff3c4448),
      outlineVariant: Color(0xff3c4448),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffb4fcd3),
      primaryFixed: Color(0xff004d31),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003420),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff504200),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff362c00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6e2f30),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff521a1b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff90d5ae),
      surfaceTint: Color(0xff90d5ae),
      onPrimary: Color(0xff003823),
      primaryContainer: Color(0xff005234),
      onPrimaryContainer: Color(0xffabf2ca),
      secondary: Color(0xffddc66e),
      onSecondary: Color(0xff3a3000),
      secondaryContainer: Color(0xff544600),
      onSecondaryContainer: Color(0xfffae287),
      tertiary: Color(0xffffb3b1),
      onTertiary: Color(0xff571d1f),
      tertiaryContainer: Color(0xff733333),
      onTertiaryContainer: Color(0xffffdad8),
      error: Color(0xffffb3ac),
      onError: Color(0xff571e1a),
      errorContainer: Color(0xff73332f),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffc0c8cc),
      outline: Color(0xff8a9296),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff256a4b),
      primaryFixed: Color(0xffabf2ca),
      onPrimaryFixed: Color(0xff002113),
      primaryFixedDim: Color(0xff90d5ae),
      onPrimaryFixedVariant: Color(0xff005234),
      secondaryFixed: Color(0xfffae287),
      onSecondaryFixed: Color(0xff221b00),
      secondaryFixedDim: Color(0xffddc66e),
      onSecondaryFixedVariant: Color(0xff544600),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff3b080c),
      tertiaryFixedDim: Color(0xffffb3b1),
      onTertiaryFixedVariant: Color(0xff733333),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff94dab3),
      surfaceTint: Color(0xff90d5ae),
      onPrimary: Color(0xff001b0e),
      primaryContainer: Color(0xff5a9e7b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe1ca72),
      onSecondary: Color(0xff1c1600),
      secondaryContainer: Color(0xffa4903e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffb9b7),
      onTertiary: Color(0xff340407),
      tertiaryContainer: Color(0xffcb7a79),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab3),
      onError: Color(0xff330404),
      errorContainer: Color(0xffcc7b74),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xfff6fcfd),
      onSurfaceVariant: Color(0xffc4ccd0),
      outline: Color(0xff9ca4a8),
      outlineVariant: Color(0xff7c8489),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff015335),
      primaryFixed: Color(0xffabf2ca),
      onPrimaryFixed: Color(0xff00150a),
      primaryFixedDim: Color(0xff90d5ae),
      onPrimaryFixedVariant: Color(0xff003f27),
      secondaryFixed: Color(0xfffae287),
      onSecondaryFixed: Color(0xff161100),
      secondaryFixedDim: Color(0xffddc66e),
      onSecondaryFixedVariant: Color(0xff413500),
      tertiaryFixed: Color(0xffffdad8),
      onTertiaryFixed: Color(0xff2c0104),
      tertiaryFixedDim: Color(0xffffb3b1),
      onTertiaryFixedVariant: Color(0xff5e2324),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeefff2),
      surfaceTint: Color(0xff90d5ae),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff94dab3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf5),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe1ca72),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb9b7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab3),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff6fbff),
      outline: Color(0xffc4ccd0),
      outlineVariant: Color(0xffc4ccd0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff00311e),
      primaryFixed: Color(0xffaff6ce),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff94dab3),
      onPrimaryFixedVariant: Color(0xff001b0e),
      secondaryFixed: Color(0xffffe68b),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe1ca72),
      onSecondaryFixedVariant: Color(0xff1c1600),
      tertiaryFixed: Color(0xffffe0de),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb9b7),
      onTertiaryFixedVariant: Color(0xff340407),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
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
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
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
