part of 'weather_bloc.dart';

class WeatherBlocState {}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherThemeChange extends WeatherBlocState {
  final ThemeMode themeMode;

  WeatherThemeChange(this.themeMode);
}
