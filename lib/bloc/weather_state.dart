part of 'weather_bloc.dart';

class WeatherBlocState {}

class WeatherBlocInitial extends WeatherBlocState {}

class WeatherThemeChange extends WeatherBlocState {
  final ThemeMode themeMode;

  WeatherThemeChange(this.themeMode);
}

class WeatherEmpty extends WeatherBlocState {}

class WeatherLoading extends WeatherBlocState {}

class WeatherLoaded extends WeatherBlocState {
  final Weather weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherBlocState {
  final int errorCode;

  WeatherError({required this.errorCode}) : assert(errorCode != null);
}
