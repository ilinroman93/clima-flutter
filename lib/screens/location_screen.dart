import 'package:clima/store/weather_store.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LocationScreen extends StatelessWidget {
  static const id = 'location_screen';

  @override
  Widget build(BuildContext context) {
    WeatherStore _weatherStore = Provider.of<WeatherStore>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _weatherStore.getWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName =
                          await Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ));
                      if (typedName != null) {
                        getWeather(context, cityName: typedName);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Observer(
                // ignore: missing_return
                builder: (context) {
                  print(_weatherStore.state);
                  switch (_weatherStore.state) {
                    case StoreState.initial:
                      return buildInitial();
                    case StoreState.loading:
                      return buildLoading();
                    case StoreState.loaded:
                      return buildColumnWithData(_weatherStore.weather);
                    default:
                      return buildInitial();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                '${weather.temperature}°',
                style: kTempTextStyle,
              ),
              Text(
                '${weather.weatherIcon}️',
                style: kConditionTextStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Text(
            '${weather.weatherMessage} ${weather.cityName}',
            textAlign: TextAlign.right,
            style: kMessageTextStyle,
          ),
        ),
      ],
    );
  }

  Widget buildInitial() {
    return Center(
      child: Text(
        'Select city or use location to get weather',
        style: kMessageTextStyle,
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void getWeather(BuildContext context, {String cityName}) {
    final weatherStore = Provider.of<WeatherStore>(context, listen: false);
    if (cityName != null) {
      weatherStore.getWeather(cityName: cityName);
    } else {
      weatherStore.getWeather();
    }
  }
}
