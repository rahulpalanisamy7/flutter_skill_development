 import 'package:flutter/material.dart';
import 'package:flutter_skill_development/widgets/CustomDrawer.dart';

import 'DashboardScreen.dart';
import 'JobAlertScreen.dart';
import 'TopicScreen.dart';
import 'auth/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {

  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  int _selectedIndex  = 0;

  final List<Widget> _tabs = [
    DashboardScreen(title: "Dashboard"),
    ProfileScreen(title: 'Profile',),
    TopicScreen(title: 'Explorer'),
    JobAlertScreen(title: "Job Alert"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
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
        // selectedItemColor: Colors.blue, // Highlight selected item
        // unselectedItemColor: Colors.grey,
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
            label: 'Job Alert',
          ),
        ],
      ),
    );
  }
}
