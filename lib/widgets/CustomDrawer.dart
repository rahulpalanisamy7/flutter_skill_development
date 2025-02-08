import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/SettingScreen.dart';

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
            icon: Icons.home,
            text: "Home",
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: "Profile",
            onTap: () {
              Navigator.pop(context); // Close drawer
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
