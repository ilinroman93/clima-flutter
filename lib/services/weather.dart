import 'package:flutter/cupertino.dart';

class Weather {
  final int temperature;
  final String weatherIcon;
  final String cityName;
  final String weatherMessage;

  Weather(
      {@required this.temperature,
      @required this.weatherIcon,
      @required this.cityName,
      @required this.weatherMessage});
}
