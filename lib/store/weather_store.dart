import 'package:clima/services/weather.dart';
import 'package:clima/services/weatherModel.dart';
import 'package:mobx/mobx.dart';

part 'weather_store.g.dart';

class WeatherStore extends _WeatherStore with _$WeatherStore {
  WeatherStore(WeatherModel weatherModel) : super(weatherModel);
}

enum StoreState { initial, loading, loaded }

abstract class _WeatherStore with Store {
  final WeatherModel _weatherModel;

  _WeatherStore(this._weatherModel);

  @observable
  ObservableFuture<Weather> _weatherFuture;

  @observable
  Weather weather;

  @computed
  StoreState get state {
    if (_weatherFuture == null ||
        _weatherFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _weatherFuture.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future<void> getWeather({String cityName}) async {
    if (cityName != null) {
      try {
        _weatherFuture =
            ObservableFuture(_weatherModel.getCityWeather(cityName));
        weather = await _weatherFuture;
      } catch (e) {
        print(e);
      }
    } else {
      try {
        _weatherFuture = ObservableFuture(_weatherModel.getWeather());
        weather = await _weatherFuture;
      } catch (e) {
        print(e);
      }
    }
  }

//  @action
//  Future<void> getLocationWeather() async {
//    try {
//      _weatherFuture = ObservableFuture(_weatherModel.getWeather());
//      weather = await _weatherFuture;
//    } catch (e) {
//      print(e);
//    }
//  }
}
