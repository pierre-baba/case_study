part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final WeatherParams params;
  final int selectedIndex;

  String get temperatureUnitSymbol => params.unit == 'imperial' ? '°F' : '°C';
  String get windSpeedUnitSymbol => params.unit == 'imperial' ? 'mi/h' : 'm/s';

  WeatherLoaded({
    required this.weather,
    required this.params,
    this.selectedIndex = 0,
  });

  WeatherLoaded copyWith({
    WeatherModel? weather,
    WeatherParams? params,
    int? selectedIndex,
  }) {
    return WeatherLoaded(
      weather: weather ?? this.weather,
      params: params ?? this.params,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [weather, params, selectedIndex];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
