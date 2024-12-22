import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  SharedPreferences? _prefs;

  SharedPrefHelper._internal();

  static SharedPrefHelper get instance => _instance;

  /// Initializes the SharedPreferences instance.
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      print('SharedPreferences initialized successfully.');
    } catch (e) {
      print('Error initializing SharedPreferences: $e');
    }
  }

  /// Sets a boolean value.
  Future<bool> setBool(String key, bool value) async {
    return _prefs!.setBool(key, value);
  }

  /// Gets a boolean value.

  bool? getBool(String key) {
    if (_prefs == null) {
      print('Error: SharedPreferences is not initialized.');
      return null;
    }
    final value = _prefs!.getBool(key);
    print('getBool: key=$key, value=$value');
    return value;
  }

  /// Sets a string value.
  Future<bool> setString(String key, String value) async {
    return _prefs!.setString(key, value);
  }

  /// Gets a string value.
  String? getString(String key) {
    return _prefs!.getString(key);
  }

  /// Sets an integer value.
  Future<bool> setInt(String key, int value) async {
    return _prefs!.setInt(key, value);
  }

  /// Gets an integer value.
  int? getInt(String key) {
    return _prefs!.getInt(key);
  }

  /// Removes a value.
  Future<bool> remove(String key) async {
    return _prefs!.remove(key);
  }
}
