import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282474385),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292338687),
      onPrimaryContainer: Color(4278197054),
      secondary: Color(4282212240),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292142079),
      onSecondaryContainer: Color(4278197306),
      tertiary: Color(4278871936),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290374399),
      onTertiaryContainer: Color(4278198057),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282664782),
      outline: Color(4285822847),
      outlineVariant: Color(4291086032),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292338687),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278197306),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4280436854),
      tertiaryFixed: Color(4290374399),
      onTertiaryFixed: Color(4278198057),
      tertiaryFixedDim: Color(4287221997),
      onTertiaryFixedVariant: Color(4278209889),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4280501107),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283987368),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280173682),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283725480),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278208860),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4281367959),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      onSurfaceVariant: Color(4282401610),
      outline: Color(4284243815),
      outlineVariant: Color(4286085763),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4283987368),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282277006),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283725480),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282015117),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281367959),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278412413),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278198602),
      surfaceTint: Color(4282474385),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280501107),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278198854),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4280173682),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278199857),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278208860),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280362027),
      outline: Color(4282401610),
      outlineVariant: Color(4282401610),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217078),
      inversePrimary: Color(4293258495),
      primaryFixed: Color(4280501107),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278463579),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4280173682),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278201688),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278208860),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202687),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467168),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4293059305),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289382399),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278923359),
      primaryContainer: Color(4280829815),
      onPrimaryContainer: Color(4292338687),
      secondary: Color(4289120511),
      onSecondary: Color(4278268254),
      secondaryContainer: Color(4280436854),
      onSecondaryContainer: Color(4292142079),
      tertiary: Color(4287221997),
      onTertiary: Color(4278203716),
      tertiaryContainer: Color(4278209889),
      onTertiaryContainer: Color(4290374399),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309080),
      onSurface: Color(4293059305),
      onSurfaceVariant: Color(4291086032),
      outline: Color(4287533209),
      outlineVariant: Color(4282664782),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4282474385),
      primaryFixed: Color(4292338687),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4280829815),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278197306),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4280436854),
      tertiaryFixed: Color(4290374399),
      onTertiaryFixed: Color(4278198057),
      tertiaryFixedDim: Color(4287221997),
      onTertiaryFixedVariant: Color(4278209889),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280164389),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4289842175),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278195765),
      primaryContainer: Color(4285829575),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4289580287),
      onSecondary: Color(4278195761),
      secondaryContainer: Color(4285567686),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287485425),
      onTertiary: Color(4278196514),
      tertiaryContainer: Color(4283538101),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294703871),
      onSurfaceVariant: Color(4291349204),
      outline: Color(4288717740),
      outlineVariant: Color(4286612364),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4280895608),
      primaryFixed: Color(4292338687),
      onPrimaryFixed: Color(4278194475),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4279449189),
      secondaryFixed: Color(4292142079),
      onSecondaryFixed: Color(4278194472),
      secondaryFixedDim: Color(4289120511),
      onSecondaryFixedVariant: Color(4278925157),
      tertiaryFixed: Color(4290374399),
      onTertiaryFixed: Color(4278195227),
      tertiaryFixedDim: Color(4287221997),
      onTertiaryFixedVariant: Color(4278205516),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280164389),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289382399),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289842175),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4289580287),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294376447),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287485425),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309080),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291349204),
      outlineVariant: Color(4291349204),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059305),
      inversePrimary: Color(4278266201),
      primaryFixed: Color(4292732927),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289842175),
      onPrimaryFixedVariant: Color(4278195765),
      secondaryFixed: Color(4292601855),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4289580287),
      onSecondaryFixedVariant: Color(4278195761),
      tertiaryFixed: Color(4291096063),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287485425),
      onTertiaryFixedVariant: Color(4278196514),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280164389),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281546042),
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
