part of 'weather_bloc.dart';

class WeatherBlocEvent {}

class ThemeChangeEvent extends WeatherBlocEvent {
  final ThemeMode themeMode;

  ThemeChangeEvent(this.themeMode);
}

class FetchWeatherEvent extends WeatherBlocEvent {
  final double latitude;
  final double longitude;

  FetchWeatherEvent({required this.latitude, required this.longitude});
}
