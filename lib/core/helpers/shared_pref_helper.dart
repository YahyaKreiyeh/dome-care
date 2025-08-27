import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    log('SharedPrefHelper: removed key: $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences.
  static Future<void> clearAllData() async {
    log('SharedPrefHelper: cleared all data');
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, Object value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    log('SharedPrefHelper: setData key: $key, value: $value');

    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    } else {
      throw ArgumentError(
        'Unsupported value type for SharedPreferences: ${value.runtimeType}',
      );
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool> getBool(String key) async {
    log('SharedPrefHelper: getBool key: $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    log('SharedPrefHelper: getDouble key: $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    log('SharedPrefHelper: getInt key: $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets a String value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    log('SharedPrefHelper: getString key: $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    const storage = FlutterSecureStorage();
    log('SecureStorage: set key: $key');
    await storage.write(key: key, value: value);
  }

  /// Gets a String value from FlutterSecureStorage with given [key].
  static Future<String> getSecuredString(String key) async {
    const storage = FlutterSecureStorage();
    log('SecureStorage: get key: $key');
    return await storage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage.
  static Future<void> clearAllSecuredData() async {
    log('SecureStorage: cleared all data');
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  /// Removes a single key from FlutterSecureStorage.
  static Future<void> deleteSecured(String key) async {
    const storage = FlutterSecureStorage();
    log('SecureStorage: delete key: $key');
    await storage.delete(key: key);
  }
}
