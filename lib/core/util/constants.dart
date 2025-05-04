class AppConstants {
  static const String baseUrl = 'https://api.openweathermap.org/';
  static const String apiKey = '3ea0776363c5a593ac44b18613cf25b3';

  static String getIconUrl(String? iconCode) {
    return iconCode != null
        ? "https://openweathermap.org/img/wn/$iconCode@4x.png"
        : "";
  }
}
