import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String baseUrl = 'https://api.openweathermap.org/';
  static String apiKey = dotenv.env['API_KEY'] ?? "";

  static String getIconUrl(String? iconCode) {
    return iconCode != null
        ? "https://openweathermap.org/img/wn/$iconCode@4x.png"
        : "";
  }
}
