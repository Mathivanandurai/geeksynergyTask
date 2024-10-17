import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/sign_up_model.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _isLoggedIn = 'is_logged_in';
  static const String _userList = 'user_list';


  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setLoggedInStatus(bool isLoggedIn) =>
      _sharedPreferences.setBool(_isLoggedIn, isLoggedIn);

  /// get if the current theme type is light
  static bool getLoggedInStatus() =>
      _sharedPreferences.getBool(_isLoggedIn) ?? false;

  /// set theme current type as light theme
  static Future<void> setUsersList( SignUpModel model)  {
    List<String> temps=  getUsersList();
   List<String> tempList=temps..add(json.encode(model.toJson()));
    return  _sharedPreferences.setStringList(_userList, tempList);
  }


  /// get if the current theme type is light
  static List<String> getUsersList() =>
      _sharedPreferences.getStringList(_userList) ?? [];

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();
}
