import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'weather.dart';

const apiKey = 'e8c39c1835fc802d51736f4099f7303c';
const baseURL = 'https://api.openweathermap.org/data/2.5/weather?&units=metric';

class WeatherModel {
  NetworkHelper networkHelper = NetworkHelper();

  Future<Weather> getCityWeather(String cityName) async {
    String url = '$baseURL&q=$cityName&appid=$apiKey';
    var weatherData = await networkHelper.getData(url);
    double temp = weatherData['main']['temp'];
    return Weather(
      temperature: temp.toInt(),
      cityName: weatherData['name'],
      weatherIcon: getWeatherIcon(weatherData['weather'][0]['id']),
      weatherMessage: getMessage(temp.toInt()),
    );
  }

  Future<Weather> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        '$baseURL&lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey';
    var weatherData = await networkHelper.getData(url);
    double temp = weatherData['main']['temp'];
    return Weather(
      temperature: temp.toInt(),
      cityName: weatherData['name'],
      weatherIcon: getWeatherIcon(weatherData['weather'][0]['id']),
      weatherMessage: getMessage(temp.toInt()),
    );
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in';
    } else {
      return 'Bring a 🧥 just in case in';
    }
  }
}
