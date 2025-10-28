class WeatherDetailsModel {

  final String cityName;
  final String countryName;

  final int temp;
  final int maxTemp;
  final int minTemp;

  final String weather;

  final String image;
  final String sunrise;
  final String sunset;

  final int feelsLike;

  final int pressure;

  final int humidity;

  final int visibility;

  final int windSpeed;
  final int uv;

  WeatherDetailsModel({
    required this.sunrise,
    required this.sunset,
    required this.uv,
    required this.cityName,
    required this.countryName,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weather,
    required this.image,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,

  });
}
