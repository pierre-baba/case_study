class WeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List<WeatherListItemData>? weatherListItemData;
  CityModel? city;

  WeatherModel({this.cod, this.message, this.cnt, this.weatherListItemData, this.city});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    weatherListItemData = json['list'] != null
        ? List.from(json['list'].map((e) => WeatherListItemData.fromJson(e)))
        : [];

    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
  }
}

class WeatherListItemData {
  int? dt;
  MainItemData? mainItemData;
  List<WeatherItemData>? weatherItemData;
  CloudsItem? cloudsItem;
  WindItemData? windItemData;
  int? visibility;
  double? pop;
  String? dtTxt;

  WeatherListItemData({
    this.dt,
    this.mainItemData,
    this.weatherItemData,
    this.cloudsItem,
    this.windItemData,
    this.visibility,
    this.pop,
    this.dtTxt,
  });

  WeatherListItemData.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    mainItemData =
        json['main'] != null ? MainItemData.fromJson(json['main']) : null;
    weatherItemData = json['weather'] != null
        ? List.from(json['weather'].map((e) => WeatherItemData.fromJson(e)))
        : [];
    cloudsItem =
        json['clouds'] != null ? CloudsItem.fromJson(json["clouds"]) : null;
    windItemData =
        json['wind'] != null ? WindItemData.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    pop = json['pop']?.toDouble();
    dtTxt = json['dt_txt'];
  }
}

class MainItemData {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainItemData(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  MainItemData.fromJson(Map<String, dynamic> json) {
    temp = json['temp']?.toDouble();
    feelsLike = json['feels_like']?.toDouble();
    tempMin = json['temp_min']?.toDouble();
    tempMax = json['temp_max']?.toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf']?.toDouble();
  }
}

class WeatherItemData {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherItemData({this.id, this.main, this.description, this.icon});

  WeatherItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class CloudsItem {
  num? all;

  CloudsItem({this.all});

  CloudsItem.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class WindItemData {
  double? speed;
  int? deg;
  double? gust;

  WindItemData({this.speed, this.deg, this.gust});

  WindItemData.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg'];
    gust = json['gust']?.toDouble();
  }
}

class CityModel {
  int? id;
  String? name;
  CoordinateModel? coordinate;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  CityModel(
      {this.id,
      this.name,
      this.coordinate,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coordinate = json['coord'] != null
        ? CoordinateModel.fromJson(json['coord'])
        : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class CoordinateModel {
  double? lat;
  double? lon;

  CoordinateModel({this.lat, this.lon});

  CoordinateModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    lon = json['lon']?.toDouble();
  }
}
