import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './utils/settings.dart';

void main(){
  runApp(new MaterialApp(
    home: new HomePage(),
    title: "Focus",
    theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
  ));
}