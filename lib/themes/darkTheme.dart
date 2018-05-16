import 'package:flutter/material.dart';

class DarkTheme {
Color _gradientColor1 = const Color(0xff718792);
Color _gradientColor2 = const Color(0x455a64).withAlpha(255);

Color _mainButtonColor = new Color(0xff455a64);
Color _detailsColor = const Color(0x00b7a2).withAlpha(255);

Color _accentColor = Colors.blueGrey, _lightAccentColor, _darkAccentColor;

  DarkTheme();

  Color get gradientColor1 => _gradientColor1;
  Color get gradientColor2 => _gradientColor2;

  Color get mainButtonColor => _mainButtonColor;
  Color get detailsColor => _detailsColor;

  Color get accentColor => _accentColor;
  Color get lightAccentColor => _lightAccentColor;
  Color get darkAccentColor => _darkAccentColor;


}