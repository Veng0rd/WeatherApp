import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/converters.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DateTime dateNow = DateTime.now();
    String formattedDate = capitalizeFirstLetter(
        DateFormat('EEEE, d MMMM yyyy', 'ru').format(dateNow));

    return Column(children: [
      const SizedBox(height: 50),
      Text(
        'in sync',
        style: theme.textTheme.bodySmall
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
      const SizedBox(height: 30),
      Text(formattedDate,
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: theme.colorScheme.secondary)),
      const SizedBox(height: 20),
      Row(
        children: [
          Text(
            '22',
            style: theme.textTheme.displayLarge,
          ),
          Text(
            '°C',
            style: theme.textTheme.displayMedium,
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Transform.rotate(
              angle: math.pi * 0.5,
              child: Icon(
                Icons.arrow_right_alt,
                size: 21,
                color: theme.colorScheme.secondary,
              )),
          Text('16°C',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.secondary)),
          const SizedBox(width: 20),
          Transform.rotate(
              angle: math.pi * 1.5,
              child: Icon(
                Icons.arrow_right_alt,
                size: 21,
                color: theme.colorScheme.secondary,
              )),
          Text('26°C',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.secondary))
        ],
      ),
      const SizedBox(height: 50),
      SvgPicture.string(
        Constants.RAINY_CLOUD_SVG,
        width: 128,
        height: 128,
        colorFilter:
            ColorFilter.mode(theme.colorScheme.onPrimary, BlendMode.srcIn),
        theme: const SvgTheme(currentColor: Color(0xFF000000)),
      ),
      const SizedBox(height: 20),
      Text('Light Drizzle',
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: theme.colorScheme.secondary)),
      const SizedBox(height: 50),
      Row(
        children: [
          SvgPicture.string(
            Constants.SUNRISE_SVG,
            width: 21,
            height: 21,
            colorFilter:
                ColorFilter.mode(theme.colorScheme.secondary, BlendMode.srcIn),
            theme: const SvgTheme(currentColor: Color(0xFF000000)),
          ),
          const SizedBox(width: 10),
          Text(
            '09:18 AM',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.secondary),
          ),
          const SizedBox(width: 30),
          SvgPicture.string(
            Constants.SUNSET_SVG,
            width: 21,
            height: 21,
            colorFilter:
                ColorFilter.mode(theme.colorScheme.secondary, BlendMode.srcIn),
            theme: const SvgTheme(currentColor: Color(0xFF000000)),
          ),
          const SizedBox(width: 10),
          Text(
            '06:32 PM',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.secondary),
          )
        ],
      ),
      const SizedBox(height: 30)
    ]);
  }
}
