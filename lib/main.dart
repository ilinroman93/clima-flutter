import 'package:clima/services/weatherModel.dart';
import 'package:clima/store/weather_store.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:clima/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => WeatherStore(WeatherModel()),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id: (context) => LoadingScreen(),
          LocationScreen.id: (context) => LocationScreen(),
          CityScreen.id: (context) => CityScreen(),
        },
      ),
    );
  }
}
