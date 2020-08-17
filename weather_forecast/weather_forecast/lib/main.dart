import 'package:flutter/material.dart';
import 'package:weather_forecast/ui/weather_forecast.dart';

void main() {
  runApp(new MaterialApp(
    home: WeatherForecast(),
    theme: _getTheme(),
  ));
}

ThemeData _getTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.blueGrey.shade50,
      textTheme: TextTheme(
          headline6: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.9),
          headline3: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          subtitle1: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)));
}
