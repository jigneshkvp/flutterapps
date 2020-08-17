import 'package:intl/intl.dart';

class Util {
  static String appId = 'dbf2db9e9f84a85d27195487a83c1675';

  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEEE, MMM d, yyyy").format(dateTime);
  }

  static String getHour(DateTime dateTime) {
    return new DateFormat('jm').format(dateTime);
  }

  static String getShortDate(DateTime dateTime) {
    return new DateFormat('EEE, MMM d, yyyy').format(dateTime);
  }

  static String getWeatherIcon(String iconCode) {
    return "http://openweathermap.org/img/wn/$iconCode@2x.png";
  }
}
