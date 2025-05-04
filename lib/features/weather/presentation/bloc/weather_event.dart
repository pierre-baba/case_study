part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeather extends WeatherEvent {
  final WeatherParams params;

  LoadWeather({WeatherParams? params})
      : params = params ?? WeatherParams();

  @override
  List<Object> get props => [params];
}

class SelectDay extends WeatherEvent {
  final int selectedIndex;

  const SelectDay(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

class ChangeUnit extends WeatherEvent {
  const ChangeUnit();

  @override
  List<Object> get props => [];
}