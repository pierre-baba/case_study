import 'package:dartz/dartz.dart';
import 'package:flaconi/features/weather/data/models/weather_model.dart';
import 'package:flaconi/features/weather/domain/entities/weather_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/weather_repository.dart';

class GetWeather implements UseCase<WeatherModel,WeatherParams> {
  final WeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Either<Failure, WeatherModel>> call(
      params) async {
    return await repository.getWeather(params);
  }
}
