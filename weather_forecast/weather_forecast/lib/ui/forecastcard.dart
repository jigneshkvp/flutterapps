import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/util/util.dart';

class ForecastCard extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;
  final int index;

  const ForecastCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data.list;
    var dateTime =
        DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
    var fullDate = Util.getFormattedDate(dateTime);
    var dayOfTheWeek = fullDate.split(",")[0];
    var weatherIconCode = forecastList[index].weather[0].icon;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("${Util.getShortDate(dateTime)}"),
                    Text(
                      "${Util.getHour(dateTime)}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )
                //Text("$dayOfTheWeek, ${Util.getHour(dateTime)}"),
                )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
              child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 500),
                  placeholder: kTransparentImage,
                  image: Util.getWeatherIcon(weatherIconCode)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getWeatherRow(forecastList[index], "minTemperature"),
                getWeatherRow(forecastList[index], "maxTemperature"),
                getWeatherRow(forecastList[index], "humidity"),
                getWeatherRow(forecastList[index], "windspeed"),
              ],
            )
          ],
        )
      ],
    );
  }
}

Row getWeatherRow(Lista forecast, String input) {
  IconData iconData;
  Color iconColor;
  String data;

  switch (input) {
    case "maxTemperature":
      {
        iconData = FontAwesomeIcons.temperatureHigh;
        iconColor = Colors.redAccent;
        data = "${forecast.tempMaximum} °C";
      }
      break;
    case "minTemperature":
      {
        iconData = FontAwesomeIcons.temperatureLow;
        iconColor = Colors.lightBlue;
        data = "${forecast.tempMinimum} °C";
      }
      break;
    case "humidity":
      {
        iconData = FontAwesomeIcons.grinBeamSweat;
        iconColor = Colors.blueAccent;
        data = "${forecast.humidity} %";
      }
      break;
    case "windspeed":
      {
        iconData = FontAwesomeIcons.wind;
        iconColor = Colors.grey.shade600;
        data = "${forecast.windSpeed} mi/h";
      }
      break;
    default:
      {
        iconData = FontAwesomeIcons.stopCircle;
        iconColor = Colors.grey.shade600;
        data = "not found";
      }
      break;
  }

  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(data),
      ),
      // SizedBox(
      //   width: 5,
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          iconData,
          size: 12,
          color: iconColor,
        ),
      ),
    ],
  );
}
