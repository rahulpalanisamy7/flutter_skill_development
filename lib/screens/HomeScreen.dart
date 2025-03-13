import 'package:flutter/material.dart';
import 'package:flutter_skill_development/widgets/CustomDrawer.dart';

import 'DashboardScreen.dart';
import 'NotificationScreen.dart';
import 'TopicScreen.dart';
import 'auth/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  // Tabs and corresponding titles
  final List<Widget> _tabs = [
    DashboardScreen(title: "Dashboard"),
    ProfileScreen(title: 'Profile'),
    TopicScreen(title: 'Explorer'),
    NotificationScreen(title: "Notification"),
  ];

  final List<String> _tabTitles = [
    "Dashboard",
    "Profile",
    "Explorer",
    "Updates",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(parentContext: context,),
      appBar: AppBar(
        title: Text(_tabTitles[_selectedIndex]), // Update AppBar title
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Updates',
          ),
        ],
      ),
    );
  }
}
