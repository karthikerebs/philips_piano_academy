import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/preference/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: PreferenceContracts)
class PreferenceHelper implements PreferenceContracts {
  @override
  void setBool(
      {required String key, required bool value, bool? isSecure}) async {
    if (isSecure ?? false) {
      _setData(key, value.toString());
    } else {
      final p = await prefs;
      p.setBool(key, value);
    }
  }

  @override
  void setDouble(
      {required String key, required double value, bool? isSecure}) async {
    if (isSecure ?? false) {
      _setData(key, value.toString());
    } else {
      final p = await prefs;
      p.setDouble(key, value);
    }
  }

  @override
  void setInt({required String key, required int value, bool? isSecure}) async {
    if (isSecure ?? false) {
      _setData(key, value.toString());
    } else {
      final p = await prefs;
      p.setInt(key, value);
    }
  }

  @override
  void setString(
      {required String key, required String value, bool? isSecure}) async {
    if (isSecure ?? false) {
      _setData(key, value.toString());
    } else {
      final p = await prefs;
      p.setString(key, value);
    }
  }

  @override
  Future<bool> getBool({required String key, bool? isSecure}) async {
    if (isSecure ?? false) {
      final value = await _getData(key);
      return value.toLowerCase() == 'true';
    } else {
      final p = await prefs;
      return p.getBool(key) ?? false;
    }
  }

  @override
  Future<double> getDouble({required String key, bool? isSecure}) async {
    if (isSecure ?? false) {
      final value = await _getData(key);
      return double.parse(value);
    } else {
      final p = await prefs;
      return p.getDouble(key) ?? 0.0;
    }
  }

  @override
  Future<int> getInt({required String key, bool? isSecure}) async {
    if (isSecure ?? false) {
      final value = await _getData(key);
      return int.parse(value);
    } else {
      final p = await prefs;
      return p.getInt(key) ?? 0;
    }
  }

  @override
  Future<String> getString({required String key, bool? isSecure}) async {
    if (isSecure ?? false) {
      return _getData(key);
    } else {
      final p = await prefs;
      return p.getString(key) ?? '';
    }
  }

  @override
  Future<bool> clearAll({bool? isSecure}) async {
    if (isSecure ?? false) {
      const storage = FlutterSecureStorage();
      storage.deleteAll();
    } else {
      final p = await prefs;
      p.clear();
    }
    return true;
  }

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Future<String> _getData(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key) ?? '';
  }

  Future<void> _setData(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }
}
