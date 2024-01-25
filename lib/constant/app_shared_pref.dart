import 'package:shared_preferences/shared_preferences.dart';

enum AppSharedPrefKey {
  email,
  password,
  loginStatus,
  fullName,
  dob,
  gender,
  profileImage,
  lastActive
}

class AppSharedPref {
  SharedPreferences? pref;
  AppSharedPref() {
    _setup();
  }

  _setup() async{
    pref  = await SharedPreferences.getInstance();
  }

  setString({required AppSharedPrefKey key, required String value}) {
    pref?.setString(key.name, value);
  }

  String getString({required AppSharedPrefKey key}) {
    return pref?.getString(key.name) ?? "";
  }

  setBool({required AppSharedPrefKey key, required bool value}) {
    pref?.setBool(key.name, value);
  }

  bool getBool({required AppSharedPrefKey key}) {
    return pref?.getBool(key.name) ?? false;
  }

  void remove(AppSharedPrefKey key){
    pref?.remove(key.name);
  }

  void clear() async {
    pref?.clear();
  }
}
