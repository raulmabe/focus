import 'package:flutter/material.dart';

class PinkTheme {

  

Color _gradientColor1 = const Color.fromARGB(255, 253, 72, 72);
Color _gradientColor2 = const Color.fromARGB(255, 87, 97, 249);

Color _mainButtonColor = Colors.pink.shade300;
Color _detailsColor = Colors.pink[800];

Color _accentColor = Colors.pinkAccent, _lightAccentColor, _darkAccentColor;

  PinkTheme();

  
  Color get gradientColor1 => _gradientColor1;
  Color get gradientColor2 => _gradientColor2;

  Color get mainButtonColor => _mainButtonColor;
  Color get detailsColor => _detailsColor;

  Color get accentColor => _accentColor;
  Color get lightAccentColor => _lightAccentColor;
  Color get darkAccentColor => _darkAccentColor;
}