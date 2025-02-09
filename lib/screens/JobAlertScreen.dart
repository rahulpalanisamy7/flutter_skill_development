import 'package:flutter/material.dart';

class JobAlertScreen extends StatefulWidget {
  final String title;

  const JobAlertScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<JobAlertScreen> createState() => _JobAlertScreenState();
}

class _JobAlertScreenState extends State<JobAlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Job Alert Screen'),
      ),
    );
  }
}
