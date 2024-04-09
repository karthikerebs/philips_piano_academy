abstract class PreferenceContracts {
  Future<String> getString({required String key, bool isSecure = false});
  Future<bool> getBool({required String key, bool isSecure = false});
  Future<int> getInt({required String key, bool isSecure = false});
  Future<double> getDouble({required String key, bool isSecure = false});
  void setString({required String key, required String value});
  void setInt({required String key, required int value, bool isSecure = false});
  void setBool(
      {required String key, required bool value, bool isSecure = false});
  void setDouble(
      {required String key, required double value, bool isSecure = false});
  Future<bool> clearAll({bool isSecure = false});
}
