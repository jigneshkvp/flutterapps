import 'package:flutter/material.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/ui/forecast_listview.dart';
import 'package:weather_forecast/ui/weather_details.dart';
import 'package:weather_forecast/util/network.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<WeatherForecastModel> forecast;

  @override
  void initState() {
    super.initState();

    forecast = getCityWeather(cityName: 'Stockholm');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            textFieldView(),
            Container(
              child: FutureBuilder(
                future: forecast,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherForecastModel> snapshot) {
                  if (snapshot.hasData)
                    return Column(
                      children: <Widget>[
                        WeatherDetails(snapshot: snapshot),
                        ForecastList(
                          snapshot: snapshot,
                        )
                      ],
                    );
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textFieldView() {
    final snackbar = SnackBar(
      elevation: 25.0,
      content: Text('City not found'),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 200),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          child: TextField(
        decoration: InputDecoration(
          hintText: "Enter City Name",
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.all(5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onSubmitted: (value) {
          setState(() {
            try {
              forecast = getCityWeather(cityName: value);
            } catch (e) {
              Scaffold.of(context).showSnackBar(snackbar);
            }
          });
        },
      )),
    );
  }

  Future<WeatherForecastModel> getCityWeather({String cityName}) =>
      Network().getWeatherForecast(cityName: cityName);
}
