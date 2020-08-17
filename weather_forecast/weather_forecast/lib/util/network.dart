import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/util/util.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast({String cityName}) async {
    var weatherApiUrl =
        "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=${Util.appId}&units=metric";

    print(weatherApiUrl);

    var response = await get(Uri.encodeFull(weatherApiUrl));

    if (response.statusCode == 200 && response.body != null) {
      print(json.decode(response.body));
      return WeatherForecastModel.fromJson(json.decode(response.body));
    }

    throw Exception("Error receiving weather forecast response");
  }
}
