import 'package:flutter/material.dart';
import 'package:weather_app/weather_app.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ru', null);
  runApp(const WeatherApp());
}
