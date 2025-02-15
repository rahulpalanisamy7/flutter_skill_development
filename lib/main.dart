import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_skill_development/screens/HomeScreen.dart';
import 'package:flutter_skill_development/screens/SplashScreen.dart';
import 'package:flutter_skill_development/screens/TopicScreen.dart';
import 'package:flutter_skill_development/services/UiProvider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sujkhstcrknxrqamzfrp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN1amtoc3RjcmtueHJxYW16ZnJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MDA3OTYsImV4cCI6MjA1NTE3Njc5Nn0.ebIjFOBcSmopTHjV_984QcymHiFVjYuGXiiS89WsI48',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,

            title: 'Dark Theme',
            //By default theme setting, you can also set system
            // when your mobile theme is dark the app also become dark

            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,

            //Our custom theme applied
            darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,

            theme: notifier.isDark
                ? notifier.darkTheme // dark theme applied
                : notifier.redTheme, // pink theme applied when not dark

            home: SplashScreen(),

          );
        },
      ),
    );
  }
}
