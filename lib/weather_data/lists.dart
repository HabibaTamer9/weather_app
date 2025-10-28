import 'package:weather_app/weather_data/models/current_weather_model.dart';
import 'package:weather_app/weather_data/models/days_weather_model.dart';
import 'package:weather_app/weather_data/models/hourly_weather_model.dart';
import 'package:weather_app/weather_data/models/weather_details_model.dart';

class WeatherLists {
  static CurrentWeatherModel currentState = CurrentWeatherModel(
      temp: 21,
      maxTemp: 30,
      minTemp: 21,
      weather: "clear",
      image: "",
      cityName: "",
      countryName: "");
  static List<CurrentWeatherModel> citiesWeather = [];
  static List cities = [
    "Cairo",
    "London",
    "New york",
    "Dubai",
    "paris",
    "Tokyo",
    "Roma"
  ];
  static List<CurrentWeatherModel> search = [];
  static List searchCities = [];
  static List<HourlyWeatherModel> hourlyWeather = [];
  static List<DaysWeatherModel> daysWeather = [];
  static WeatherDetailsModel weatherDetails = WeatherDetailsModel(
    sunrise: "5:15",
    sunset: "6:15",
    uv: 0,
    cityName: "Cairo",
    countryName: "Egypt",
    temp: 28,
    maxTemp: 31,
    minTemp: 25,
    weather: "clear",
    image: "assets/images/moon",
    feelsLike: 28,
    pressure: 1015,
    humidity: 42,
    visibility: 6,
    windSpeed: 13,
  );
}
