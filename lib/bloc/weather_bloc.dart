import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/utils/user_preferences.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<ThemeChangeEvent>(_changeTheme);
  }

  Future<void> _changeTheme(
      ThemeChangeEvent event, Emitter<WeatherBlocState> emit) async {
    final UserPreferences pref = UserPreferences();
    await pref.setThemeMode(event.themeMode);
    emit(WeatherThemeChange(event.themeMode));
  }
}
