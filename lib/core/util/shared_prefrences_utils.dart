import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  static const String _unitKey = 'selected_unit';

  static Future<void> saveUnit(String unit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_unitKey, unit);
    } catch (e) {
    }
  }

  static Future<String> loadUnit() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_unitKey) ?? 'metric';
    } catch (e) {
      return 'metric';
    }
  }
}
