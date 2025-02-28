import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ResultScreen.dart';

class QuizScreen extends StatefulWidget {
  final String title;

  const QuizScreen({super.key, required this.title});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  List<Map<String, dynamic>> _questions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  /// Fetches quiz questions from Supabase
  Future<void> _fetchQuestions() async {
    try {
      final response = await Supabase.instance.client.from('questions').select();

      setState(() {
        _questions = response.map<Map<String, dynamic>>((q) => {
          'question': q['question'],
          'options': List<String>.from(q['options']),
          'answer': int.parse(q['answer'].toString()), // Ensure answer is an integer
        }).toList();
        _isLoading = false;
      });

      print("Fetched Questions: $_questions"); // Debugging output
    } catch (error) {
      print("Error fetching questions: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Handles answer selection and moves to the next question
  void _nextQuestion(int selectedIndex) {
    int correctAnswer = _questions[_questionIndex]['answer'] as int;

    if (selectedIndex == correctAnswer) {
      _score++; // Increase score if the answer is correct
    }

    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        // Navigate to ResultScreen with the final score
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: _score,
              totalQuestions: _questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_questionIndex]['question'] as String,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...(_questions[_questionIndex]['options'] as List<String>).map(
                  (option) => ElevatedButton(
                onPressed: () => _nextQuestion(
                  (_questions[_questionIndex]['options'] as List<String>)
                      .indexOf(option),
                ),
                child: Text(option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
