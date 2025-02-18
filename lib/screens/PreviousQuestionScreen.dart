import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/PreviousQuestionExamScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/PreviousQuestion.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class PreviousQuestionScreen extends StatefulWidget {
  final String title;

  const PreviousQuestionScreen({super.key, required this.title});

  @override
  State<PreviousQuestionScreen> createState() => _PreviousQuestionScreenState();
}

class _PreviousQuestionScreenState extends State<PreviousQuestionScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<PreviousQuestion> _previous_questions = []; // Local list of previous_questions

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'topic' table
    _supabase
        .from('previous_questions')
        .stream(primaryKey: ['id']) // Specify the primary key
        .execute()
        .listen((data) {
      setState(() {
        _previous_questions = data.map((e) => PreviousQuestion.fromMap(e)).toList();
      });
    });


    // Initial fetch of previous_questions
    _fetchInitialTopics();
  }

  Future<void> _fetchInitialTopics() async {
    final response = await _supabase.from('previous_questions').select().execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching previous_questions: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _previous_questions = (response.data as List<dynamic>)
          .map((e) => PreviousQuestion.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(parentContext: context,),
      body: _previous_questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _previous_questions.length,
        itemBuilder: (context, index) {
          final row = _previous_questions[index];

          return ListTile(
            title: Text(row.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviousQuestionExamScreen(previous_question: row),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
