import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static SharedPreferences _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> cacheData({
  String key,
    dynamic value,
  }) async {
    if (value is String) return _sharedPreferences.setString(key, value);
    if (value is bool) return _sharedPreferences.setBool(key, value);
    if (value is double) return _sharedPreferences.setDouble(key, value);
    if (value is int) return _sharedPreferences.setInt(key, value);
    return _sharedPreferences.setStringList(key, value);
  }

  static dynamic getCacheData({ String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> removeCacheData({ key}) async {
    return await _sharedPreferences.remove(key);
  }
  
  static String get lange=>CacheService.getCacheData(key:'Getlange');
  static bool get getTheme=>CacheService.getCacheData(key:'Dark');

}