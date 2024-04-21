import 'dart:convert';

import 'package:weather_app/data/api_endpoints.dart';
import 'package:weather_app/model/error_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<dynamic> getWeather(String location) async {
    final response = await http.get(Uri.parse("${APIENDPOINTS.baseUrl}weather?q=$location&units=metric&APPID=${APIENDPOINTS.APP_ID}"));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body.toString()));
    } else {
      return ErrorHandler.fromJson(jsonDecode(response.body.toString()));
    }
  }
}