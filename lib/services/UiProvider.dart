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

  final redTheme = ThemeData(
    primaryColor: Color(0xffB81736), // Hex #2196F3 (Blue),
    brightness: Brightness.light,
    primaryColorDark: Colors.pinkAccent,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xffB81736), // Pink AppBar
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white), // AppBar icons color
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xffB81736), // Default button color
      textTheme: ButtonTextTheme.primary,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Button text color
        backgroundColor: Color(0xffB81736), // Button background color
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // backgroundColor: Colors.pink, // TextButton color
        foregroundColor: Colors.white, // TextButton color
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFB81736), // Background color
      selectedItemColor: Colors.white, // Selected icon & text color
      unselectedItemColor: Colors.white70, // Unselected icon & text color
      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Selected text style
      unselectedLabelStyle: TextStyle(fontSize: 12), // Unselected text style
    ),




    // Icon Theme
    iconTheme: IconThemeData(color: Colors.pink), // Default icon color
    primaryIconTheme: IconThemeData(color: Colors.white), // Primary icon color (AppBar, etc.)

    // Text Theme
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: Colors.pinkAccent, fontSize: 18), // Large text
    //   bodyMedium: TextStyle(color: Colors.pink, fontSize: 16), // Medium text
    //   bodySmall: TextStyle(color: Colors.pink, fontSize: 14), // Small text
    //   titleLarge: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), // Large titles
    // ),


    // Navigation Drawer Theme
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: Color(0xffB81736),
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black54,
      indicatorColor: Colors.white70,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(16),
      //     bottomRight: Radius.circular(16),
      //   ),
      // ),
    ),
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