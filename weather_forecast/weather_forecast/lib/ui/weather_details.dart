import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/util/util.dart';

class WeatherDetails extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const WeatherDetails({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data.list;
    var cityName = snapshot.data.city.name;
    var countryName = snapshot.data.city.country;
    var weatherIconCode = forecastList[0].weather[0].icon;
    var formattedDateTime =
        new DateTime.fromMillisecondsSinceEpoch(forecastList[0].dt * 1000);
    var currentTemp = forecastList[0].main.temp.toStringAsFixed(0);
    var currentConditions = forecastList[0].weather[0].description;
    var windSpeed = forecastList[0].windSpeed;
    var humidity = forecastList[0].humidity;
    var tempMax = forecastList[0].tempMaximum;

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          gradient: FlutterGradients.awesomePine(),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$cityName, $countryName",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            "${Util.getFormattedDate(formattedDateTime)}, ${Util.getHour(formattedDateTime)}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 500),
                  placeholder: kTransparentImage,
                  height: 150,
                  image: Util.getWeatherIcon(weatherIconCode))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$currentTemp °C",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(" ${currentConditions.toUpperCase()}",
                    style: Theme.of(context).textTheme.headline6)
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "$windSpeed mi/h",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Icon(
                        FontAwesomeIcons.wind,
                        size: 30,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "$humidity %",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Icon(FontAwesomeIcons.grinBeamSweat,
                          size: 30, color: Colors.blueAccent),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "$tempMax °C",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Icon(
                        FontAwesomeIcons.temperatureHigh,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
