class Weather {
  final int? id;
  final int? sunrise;
  final int? sunset;

  final String? cityName;

  final double? temperature;
  final double? maxTemperature;
  final double? minTemperature;

  final List<Weather>? forecast;

  Weather({
    this.id,
    this.sunrise,
    this.sunset,
    this.cityName,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.forecast,
  });
}
