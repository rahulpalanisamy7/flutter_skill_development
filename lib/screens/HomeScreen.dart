 import 'package:flutter/material.dart';
import 'package:flutter_skill_development/widgets/CustomDrawer.dart';

import 'DashboardScreen.dart';
import 'TopicScreen.dart';
import 'auth/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {

  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  int _currentIndex = 0;

  final List<Widget> _tabs = [
    DashboardScreen(title: "Dashboard"),
    ProfileScreen(title: 'Profile',),
    TopicScreen(title: 'Explorer'),
    // JobAlertScreen(title: "job_alert"),
  ];

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
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.orange,
        // currentIndex: _currentIndex,
        // selectedItemColor: Colors.blue,
        // unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
