import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/utils/user_preferences.dart';
import 'package:weather_app/utils/theme.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  ThemeMode _themeMode = ThemeMode.system;
  late UserPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = UserPreferences();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeMode = await _prefs.getThemeMode();
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherBlocState>(
        builder: (context, state) {
          if (state is WeatherThemeChange) {
            _loadTheme();
            _themeMode = state.themeMode;
          }
          return MaterialApp(
            title: 'Wearher App',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: _themeMode,
            home: const WeatherScreen(),
          );
        },
      ),
    );
  }
}
