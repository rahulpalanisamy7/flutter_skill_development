import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier{
  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white
  );

  changeTheme(){
    _isDark = !isDark;

    storage.setBool("isDark", _isDark);
    _isDark = storage.getBool("isDark")??false;
    notifyListeners();
  }

  //Init method of provider
  init()async{
    //After we re run the app
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark")??false;
    notifyListeners();
  }
}