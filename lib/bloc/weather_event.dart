part of 'weather_bloc.dart';

class WeatherBlocEvent {}

class ThemeChangeEvent extends WeatherBlocEvent {
  final ThemeMode themeMode;

  ThemeChangeEvent(this.themeMode);
}
