import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String title;

  const UpdateScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // +
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
