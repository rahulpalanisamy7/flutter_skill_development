import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/SettingScreen.dart';
import 'package:flutter_skill_development/screens/SupportUsScreen.dart';
import 'package:flutter_skill_development/screens/auth/ProfileScreen.dart';
import 'package:flutter_skill_development/screens/auth/WelcomeBackScreen.dart';

import '../screens/AboutAppScreen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user.png'), // Ensure the asset exists
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'johndoe@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Topics",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Syllabus",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Material",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Question Bank",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Feedback",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Trainer List",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Mock Exam",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Previous Question Paper",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: "Complaint",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            text: "About App",
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutAppScreen(title: 'About App'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: "Profile",
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(title: 'Profile'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            text: "Settings",
            onTap: () {
              Navigator.pop(context); // Close drawer before navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(title: 'Settings'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.support,
            text: "Support Us",
            onTap: () {
              Navigator.pop(context); // Close drawer before navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportUsScreen(title: 'Support Us'),
                ),
              );
            },
          ),
          Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            text: "Logout",
            onTap: () {
              Navigator.pop(context); // Close drawer
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged out")),
              );
              // Implement actual logout logic here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeBackScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: onTap, // Fix: Now correctly calling the function
    );
  }
}
