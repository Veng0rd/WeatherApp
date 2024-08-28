import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Temperature'),
          content: Text('You tapped on the temperature!'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changeTheme(BuildContext context, ThemeMode themeMode) {
    BlocProvider.of<WeatherBloc>(context).add(ThemeChangeEvent(themeMode));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: theme.colorScheme.primary,
          shadowColor: theme.colorScheme.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mumbai',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Text('Current Location',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.secondary))
                ],
              ),
              Row(
                children: [
                  IconButton(
                    visualDensity:
                        const VisualDensity(horizontal: -1.75, vertical: -1.75),
                    icon: const Icon(Icons.map_outlined),
                    iconSize: 21.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    visualDensity:
                        const VisualDensity(horizontal: -1.75, vertical: -1.75),
                    iconSize: 21,
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [WeatherWidget()],
          ),
        ),
      ),
    );
  }
}
