import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

import 'package:weather_app/screens/settings_screen.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = context.read<WeatherBloc>();
    _fetchWeatherWithLocation();
  }

  Future<void> _fetchWeatherWithLocation() async {
    var permissionResult = await Permission.locationWhenInUse.status;

    switch (permissionResult) {
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        print('location permission denied');
        _showLocationDeniedDialog();
        break;

      case PermissionStatus.denied:
        await Permission.locationWhenInUse.request();
        _fetchWeatherWithLocation(); // Повторный вызов после запроса разрешения
        break;

      case PermissionStatus.limited:
      case PermissionStatus.granted:
        print('getting location');
        try {
          Position position = await Geolocator.getCurrentPosition();

          print(position.toString());

          _weatherBloc.add(FetchWeatherEvent(
            longitude: position.longitude,
            latitude: position.latitude,
          ));
        } catch (e) {
          print('Error getting location: $e');
        }
        break;
      case PermissionStatus.provisional:
    }
  }

  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
              'Location permission is required to fetch weather data.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: theme.colorScheme.primary,
          shadowColor: theme.colorScheme.primary,
          title: BlocBuilder<WeatherBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is WeatherLoaded) {}
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state is WeatherLoaded
                          ? Text(
                              state.weather.cityName.toString(),
                              style: theme.textTheme.bodyLarge,
                            )
                          : Text(
                              '---',
                              style: theme.textTheme.bodyLarge,
                            ),
                      const SizedBox(height: 5),
                      Text('Ваше местоположение',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.secondary))
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        visualDensity: const VisualDensity(
                            horizontal: -1.75, vertical: -1.75),
                        icon: const Icon(Icons.map_outlined),
                        iconSize: 21.0,
                        onPressed: () {},
                      ),
                      IconButton(
                        visualDensity: const VisualDensity(
                            horizontal: -1.75, vertical: -1.75),
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
              );
            },
          ),
        ),
        body: BlocBuilder<WeatherBloc, WeatherBlocState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [WeatherWidget(weather: state.weather)],
                ),
              );
            } else if (state is WeatherError) {
              return Center(
                child: Text(
                  'Ошибка загрузки погоды',
                  style: theme.textTheme.bodyLarge,
                ),
              );
            } else {
              return const Center(child: Text('Нет доступных данных'));
            }
          },
        ),
      ),
    );
  }
}
