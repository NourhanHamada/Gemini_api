import 'package:hive_flutter/adapters.dart';
import '../data.dart';

class HiveHelper {
  static late Box hiveBox;

  /// Initialize Hive local database
  Future hiveInit() async {
    await Hive.initFlutter();
    await Hive.openBox(AppData.hiveBoxName);
    hiveBox = Hive.box(AppData.hiveBoxName);
  }

  /// Set data with the [key] and [value]
  Future<void> setData({
    required String key,
    dynamic value,
  }) async {
    await hiveBox.put(key, value);
  }

  /// Get Data with the [key]
  dynamic getData({
    required String key,
  }) {
    dynamic storedData = hiveBox.get(
      key,
      defaultValue: [],
    );
    return storedData;
  }

  /// delete data with the [key]
  Future<void> clearData({
    required String key,
  }) async {
    await hiveBox.delete(key);
  }

  /// Clear All data
  Future<void> clearAllData() async {
    await hiveBox.clear();
  }
}
