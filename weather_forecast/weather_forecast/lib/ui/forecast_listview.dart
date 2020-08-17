import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:weather_forecast/model/weather_forecast.dart';
import 'package:weather_forecast/ui/forecastcard.dart';

class ForecastList extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const ForecastList({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data.list;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "7-Day weather forecast (every 3 hours)".toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(
                    width: 8.0,
                  ),
              itemCount: forecastList.length - 1,
              itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 3, left: 3),
                  width: MediaQuery.of(context).size.width / 2.7,
                  decoration: BoxDecoration(
                      gradient: FlutterGradients.awesomePine(),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(3, 1))
                      ]),
                  child: ForecastCard(
                    snapshot: snapshot,
                    index: index + 1,
                  ))),
        )
      ],
    );
  }
}
