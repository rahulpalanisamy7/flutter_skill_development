import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/AboutAppScreen.dart';
import 'package:flutter_skill_development/screens/FeedbackScreen.dart';
import 'package:flutter_skill_development/screens/QuestionTopicScreen.dart';
import 'package:flutter_skill_development/screens/QuizScreen.dart';
import 'package:flutter_skill_development/screens/SettingScreen.dart';
import 'package:flutter_skill_development/screens/SupportUsScreen.dart';
import 'package:flutter_skill_development/screens/SyllabusScreen.dart';
import 'package:flutter_skill_development/screens/VideoTopicScreen.dart';
import 'package:flutter_skill_development/screens/VideoTutorialScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../screens/HomeScreen.dart';
import '../screens/PreviousQuestionScreen.dart';
import '../screens/auth/LoginScreen.dart';
import '../screens/auth/ProfileScreen.dart';
import '../screens/auth/RegisterScreen.dart';

final supabase = Supabase.instance.client;
final storage = FlutterSecureStorage();

class CustomDrawer extends StatelessWidget {
  final BuildContext parentContext;

  CustomDrawer({required this.parentContext});

  Future<void> signOut() async {
    await supabase.auth.signOut();
    await storage.delete(key: 'session');

    // Navigate to login screen and remove all previous routes
    Navigator.pushReplacement(
      parentContext,
      MaterialPageRoute(
        // builder: (context) => LoginScreen(title: 'Login'),
        builder: (context) => HomeScreen(title: 'Home'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (user != null) ...[
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text(user.email ?? "No Email"),
              currentAccountPicture: CircleAvatar(
                // child: Icon(Icons.person, size: 40),
                backgroundImage: NetworkImage('https://gravatar.com/avatar/${user!.email}'), // Replace with the user's image URL
              ),
              decoration: BoxDecoration(
                color: Color(0xffB81736), // Set background color here
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(title: 'Home'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.video_call),
              title: Text('Video'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => VideoTopicScreen(title: 'Video Tutorial'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text('Quiz'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => QuestionTopicScreen(title: 'Quiz'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Syllabus'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => SyllabusScreen(title: 'Syllabus'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => FeedbackScreen(title: 'Feedback'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Previous Question'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => PreviousQuestionScreen(title: 'Previous Question'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(title: 'Settings'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => AboutAppScreen(title: 'About'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Support Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => SupportUsScreen(title: 'Support Us'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: signOut,
            ),
          ] else ...[
            UserAccountsDrawerHeader(
              accountName: Text(user != null ? "User Name" : "Guest"),
              accountEmail: Text(user?.email ?? "No Email"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                Navigator.pushReplacement(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(title: 'Login'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Register'),
              onTap: () {
                Navigator.pushReplacement(
                  parentContext,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(title: 'Register'),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}