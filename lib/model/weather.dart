class Weather {
  final int? id;
  final int? sunrise;
  final int? sunset;

  final String? cityName;
  final String? description;
  final double? temperature;
  final double? maxTemperature;
  final double? minTemperature;

  Weather({
    this.id,
    this.sunrise,
    this.sunset,
    this.cityName,
    this.description,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      description: weather['description'],
      cityName: json['name'],
      temperature: json['main']['temp'],
      maxTemperature: json['main']['temp_max'],
      minTemperature: json['main']['temp_min'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}
