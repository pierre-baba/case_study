import 'dart:convert';

import 'package:flaconi/features/weather/domain/entities/weather_params.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/constants.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(WeatherParams params);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<WeatherModel> getWeather(WeatherParams params) async {
    final response = await client.get(Uri.parse(
        '${AppConstants.baseUrl}/data/2.5/forecast?appid=${AppConstants.apiKey}&lat=${params.lat}&lon=${params.long}&cnt=${params.cnt}&units=${params.unit}'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
