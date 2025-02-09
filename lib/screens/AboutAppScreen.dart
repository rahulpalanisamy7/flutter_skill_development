import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  final String title;

  const AboutAppScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align content at the start
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'About Your Competitive Exam App',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'This app is designed to help you prepare for your competitive exams efficiently.\n\n',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Features:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold, // Make subtopics bold
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  '- Display questions and multiple-choice options.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '- Timer functionality to track your progress.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '- Submit answers and receive instant feedback.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Text(
                  'Usage:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold, // Make subtopics bold
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  '- Start by selecting an exam category.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '- Answer each question within the allocated time.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '- Submit your answers and review your performance.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                Text(
                  'Get ready to ace your exams with our app!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold, // Make subtopics bold
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
