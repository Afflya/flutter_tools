import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._internal();

  ///
  /// Read
  ///

  static Future<String?> readString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> readInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<double?> readDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool?> readBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  ///
  /// Write
  ///

  static Future<bool> writeString(
    String key, {
    required String? value,
  }) async {
    if (value == null) return remove(key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> writeInt(
    String key, {
    required int? value,
  }) async {
    if (value == null) return remove(key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<bool> writeDouble(
    String key, {
    required double? value,
  }) async {
    if (value == null) return remove(key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<bool> writeBool(
    String key, {
    required bool? value,
  }) async {
    if (value == null) return remove(key);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  ///
  /// Options
  ///

  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<void> removeByPrefix(String prefix) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((element) => element.startsWith(prefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
