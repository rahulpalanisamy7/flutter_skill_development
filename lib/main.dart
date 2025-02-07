import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_skill_development/screens/HomeScreen.dart';
import 'package:flutter_skill_development/screens/SplashScreen.dart';
import 'package:flutter_skill_development/screens/TopicScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      // home: HomeScreen(title: 'Sign Language Converter'),
      home: SplashScreen(),
    );
  }
}
