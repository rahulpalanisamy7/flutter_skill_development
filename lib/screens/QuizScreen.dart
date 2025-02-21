import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String title;

  const QuizScreen({super.key, required this.title});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  List<Map<String, Object>> _questions = [
    {
      'question': 'What is Flutter?',
      'options': ['A Bird', 'A Framework', 'A Language', 'A Car'],
      'answer': 1
    },
    {
      'question': 'Who developed Flutter?',
      'options': ['Apple', 'Google', 'Microsoft', 'Facebook'],
      'answer': 1
    }
  ];

  void _nextQuestion(int selectedIndex) {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_questionIndex]['question'] as String,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...(_questions[_questionIndex]['options'] as List<String>).map(
                  (option) => ElevatedButton(
                onPressed: () => _nextQuestion(
                    (_questions[_questionIndex]['options'] as List<String>)
                        .indexOf(option)),
                child: Text(option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Quiz Completed!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
