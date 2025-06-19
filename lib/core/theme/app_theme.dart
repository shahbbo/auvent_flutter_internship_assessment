import 'package:flutter/material.dart';

LightCodeColors get appTheme => AppTheme().themeColor();
ThemeData get theme => AppTheme().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class AppTheme {
  // The current app theme
  final _appTheme = 'lightCode';

  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = const ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get black => const Color(0xFF1E1E1E);
  Color get white => const Color(0xFFFFFFFF);

  // Additional Colors
  Color get whiteCustom => Colors.white;
  Color get blackCustom => Colors.black;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get colorFF8900 => const Color(0xFF8900FE);
  Color get colorFFFFDE => const Color(0xFFFFDE59);
  Color get colorFFF9F9 => const Color(0xFFF9F9F9);
  Color get colorFFD9D9 => const Color(0xFFD9D9D9);
  Color get colorFFF5F6 => const Color(0xFFF5F6F7);
  Color get colorFF474B => const Color(0xFF474B51);
  Color get color33C4C4C4 => const Color(0x33C4C4C4);
  Color get color4D000000 => const Color(0x4D000000);
  Color get colorFF677294B => const Color(0xFF677294);
  Color get colorFF1E1E => const Color(0xFF1E1E1E);
  Color get colorFFF5F5 => const Color(0xFFF5F5F5);
  Color get colorFFFFEE => const Color(0xFFFFEEE6);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
}
