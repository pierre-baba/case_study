import 'package:dartz/dartz.dart';
import 'package:flaconi/features/weather/data/models/weather_model.dart';
import 'package:flaconi/features/weather/domain/entities/weather_params.dart';

import '../../../../core/error/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherModel>> getWeather(WeatherParams params);
}
