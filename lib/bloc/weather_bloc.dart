import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/api/http_exception.dart';
import 'package:weather_app/api/weather_api_client.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/utils/user_preferences.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<ThemeChangeEvent>(_changeTheme);
    on<FetchWeatherEvent>(_fetchWeather);
  }

  Future<void> _changeTheme(
      ThemeChangeEvent event, Emitter<WeatherBlocState> emit) async {
    final UserPreferences pref = UserPreferences();
    await pref.setThemeMode(event.themeMode);
    emit(WeatherThemeChange(event.themeMode));
  }

  Future<void> _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherBlocState> emit) async {
    emit(WeatherLoading());
    WeatherApiClient weatherApiClient = WeatherApiClient();
    try {
      final weather = await weatherApiClient.getWeatherFromLocation(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      emit(WeatherLoaded(weather: weather));
    } catch (exception) {
      if (exception is HTTPException) {
        emit(WeatherError(errorCode: exception.code));
      } else {
        emit(WeatherError(errorCode: 500));
      }
    }
  }
}
