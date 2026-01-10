import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static const String _keyName = 'name';
  static const String _keyImage = 'image';

  Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  Future<bool> setSettings(String name, String image) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setString(_keyName, name) &&
          await prefs.setString(_keyImage, image);
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, String>> getSettings() async {
    try {
      final prefs = await _getPrefs();
      return {
        _keyName: prefs.getString(_keyName) ?? '',
        _keyImage: prefs.getString(_keyImage) ?? '',
      };
    } catch (_) {
      return {};
    }
  }
}
