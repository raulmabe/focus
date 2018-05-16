import 'package:flutter/material.dart';

class GreenTheme {
Color _gradientColor1 = const Color.fromARGB(255 , 22, 206, 206);
Color _gradientColor2 = Colors.greenAccent;

Color _mainButtonColor = Colors.teal[400];
Color _detailsColor = Colors.teal;

Color _accentColor = Colors.greenAccent, _lightAccentColor, _darkAccentColor;

  GreenTheme();

  Color get gradientColor1 => _gradientColor1;
  Color get gradientColor2 => _gradientColor2;

  Color get mainButtonColor => _mainButtonColor;
  Color get detailsColor => _detailsColor;

  Color get accentColor => _accentColor;
  Color get lightAccentColor => _lightAccentColor;
  Color get darkAccentColor => _darkAccentColor;


}
