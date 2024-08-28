import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/utils/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  void _changeTheme(BuildContext context, ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
    BlocProvider.of<WeatherBloc>(context).add(ThemeChangeEvent(themeMode));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = UserPreferences().getThemeMode();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            surfaceTintColor: theme.colorScheme.primary,
            shadowColor: theme.colorScheme.primary,
            title: const Text('Settings')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Light'),
                trailing: BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    return _themeMode == ThemeMode.light
                        ? Icon(Icons.check, color: theme.colorScheme.onPrimary)
                        : const SizedBox.shrink();
                  },
                ),
                onTap: () => _changeTheme(context, ThemeMode.light),
              ),
              ListTile(
                title: const Text('Dark'),
                trailing: BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    return _themeMode == ThemeMode.dark
                        ? Icon(Icons.check, color: theme.colorScheme.onPrimary)
                        : const SizedBox.shrink();
                  },
                ),
                onTap: () => _changeTheme(context, ThemeMode.dark),
              )
            ],
          ),
        ),
      ),
    );
  }
}
