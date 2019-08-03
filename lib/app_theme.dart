import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData build() => ThemeData(
    primaryColor: Color(0xff005975),
    primaryColorDark: Color(0xff033848),
    accentColor: Color(0xff0bbf9f),
    backgroundColor: Color(0xffeeeeee),
    brightness: Brightness.light,

    textTheme: TextTheme(
      display1: TextStyle(
        fontFamily: 'Betty'
      ),
      display2: TextStyle(
        fontFamily: 'Betty',
        color: Color(0xff005975),
      )
    ),
  );
}