import 'package:equatable/equatable.dart';
import 'package:flaconi/features/weather/data/models/weather_model.dart';
import 'package:flaconi/features/weather/domain/entities/weather_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherParams _params = WeatherParams();

  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    on<LoadWeather>(_onLoadWeather);
    on<SelectDay>(_onSelectDay);
    on<ChangeUnit>(_onChangeUnit);
  }

  Future<void> _onLoadWeather(
      LoadWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await getWeather(event.params);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(
        WeatherLoaded(
          weather: weather,
          selectedIndex: 0,
          params: event.params,
        ),
      ),
    );
  }

  void _onSelectDay(SelectDay event, Emitter<WeatherState> emit) {
    final currentState = state;
    if (currentState is WeatherLoaded) {
      emit(currentState.copyWith(selectedIndex: event.selectedIndex));
    }
  }

  Future<void> _onChangeUnit(
      ChangeUnit event, Emitter<WeatherState> emit) async {
    final currentState = state;
    if (currentState is WeatherLoaded) {
      final newUnit = currentState.params.unit == "metric" ? "imperial" : "metric";
      emit(WeatherLoading());
      final result =
          await getWeather(currentState.params.copyWith(unit: newUnit));
      result.fold(
        (failure) => emit(WeatherError(failure.message)),
        (weather) => emit(
          WeatherLoaded(
              weather: weather,
              selectedIndex: 0,
              params: currentState.params.copyWith(unit: newUnit)),
        ),
      );
    }
  }
}
