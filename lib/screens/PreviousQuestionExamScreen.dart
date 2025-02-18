import 'package:flutter/material.dart';
import 'package:flutter_skill_development/models/PreviousQuestionExam.dart';
import 'package:flutter_skill_development/screens/PreviousQuestionExamDetailScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/PreviousQuestion.dart';


class PreviousQuestionExamScreen extends StatefulWidget {
  final PreviousQuestion previous_question;

  const PreviousQuestionExamScreen({super.key, required this.previous_question});

  @override
  State<PreviousQuestionExamScreen> createState() => _PreviousQuestionExamScreenState();
}

class _PreviousQuestionExamScreenState extends State<PreviousQuestionExamScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<PreviousQuestionExam> _previous_question_exams = []; // Local list of previous_question_exams for real-time updates

  @override
  void initState() {
    super.initState();
    print(widget.previous_question.id);

    // Listen for real-time updates from the 'previous_question_exams' table
    _supabase
        .from('previous_question_exams')
        .stream(primaryKey: ['id']) // Specify the primary key
        .eq('previous_question_id', widget.previous_question.id) // Filter by previous_question_id
        .execute()
        .listen((data) {
      setState(() {
        _previous_question_exams = data.map((e) => PreviousQuestionExam.fromMap(e)).toList();
      });

      print(_previous_question_exams.toString());
    });

    // Initial fetch of previous_question_exams
    _fetchInitialExams();
  }

  Future<void> _fetchInitialExams() async {
    final response = await _supabase
        .from('previous_question_exams')
        .select()
        .eq('previous_question_id', widget.previous_question.id) // Filter by previous_question_id
        .execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching previous_question_exams: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _previous_question_exams = (response.data as List<dynamic>)
          .map((e) => PreviousQuestionExam.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.previous_question.name)),
      body: _previous_question_exams.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loader while data is fetched
          : ListView.builder(
        itemCount: _previous_question_exams.length,
        itemBuilder: (context, index) {
          final PreviousQuestionExam exam = _previous_question_exams[index];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviousQuestionExamDetailScreen(previous_question_exam: exam),
                ),
              );
            },
            title: Text(exam.name),
          );
        },
      ),
    );
  }
}
