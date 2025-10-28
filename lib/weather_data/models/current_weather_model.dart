class CurrentWeatherModel {
  final String cityName;
  final String countryName;
  final int temp;
  final int maxTemp;
  final int minTemp;
  int hour;
  final String weather;
  final String image;
  bool isNight ;

  CurrentWeatherModel( {
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weather,
    required this.image,
    required this.cityName,
    required this.countryName,
    this.isNight = false,
    this.hour=0,
  });
}
