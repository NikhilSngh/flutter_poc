import 'dart:convert';
import 'package:flutter_poc/constant/pref_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  SharedPreferences? _pref;
  AppSharedPref() {
    _setup();
  }

  _setup() async{
    _pref  = await SharedPreferences.getInstance();
  }

  setString({required PrefKey key, required String value}) {
    _pref?.setString(key.name, value);
  }

  String getString({required PrefKey key}) {
    return _pref?.getString(key.name) ?? "";
  }

  setBool({required PrefKey key, required bool value}) {
    _pref?.setBool(key.name, value);
  }

  bool getBool({required PrefKey key}) {
    return _pref?.getBool(key.name) ?? false;
  }

  setInt({required PrefKey key, required int value}) {
    _pref?.setInt(key.name, value);
  }

  int getInt({required PrefKey key}) {
    return _pref?.getInt(key.name) ?? 0;
  }

  void remove(PrefKey key){
    _pref?.remove(key.name);
  }

  void clear() async {
    _pref?.clear();
  }

  // Save and retrieve a list of JSON using a model
  List<T> getList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonStringList = _pref?.getStringList(key);
    if (jsonStringList != null) {
      return jsonStringList.map((jsonString) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return fromJson(jsonMap);
      }).toList();
    }
    return [];
  }

  Future<bool> saveList(String key, List<dynamic> list) async {
    final jsonStringList = list.map((item) => json.encode(item)).toList();
    return await _pref?.setStringList(key, jsonStringList) ?? false;
  }

  // Remove a list from SharedPreferences
  Future<void> removeList(String key) async {
    await _pref?.remove(key);
  }

  static Future<bool> saveSingleString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?> getSingleString(String? key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
