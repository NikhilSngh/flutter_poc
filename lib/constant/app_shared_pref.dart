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
}
