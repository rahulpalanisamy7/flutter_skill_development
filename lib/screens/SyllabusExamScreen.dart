import 'package:flutter/material.dart';
import 'package:flutter_skill_development/models/SyllabusExamMaterial.dart';
import 'package:flutter_skill_development/screens/ExamDetailScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/Syllabus.dart';
import '../models/Exam.dart';
import '../models/SyllabusExam.dart';
import 'SyllabusExamDetailScreen.dart';

class SyllabusExamScreen extends StatefulWidget {
  final Syllabus syllabus;

  const SyllabusExamScreen({super.key, required this.syllabus});

  @override
  State<SyllabusExamScreen> createState() => _SyllabusExamScreenState();
}

class _SyllabusExamScreenState extends State<SyllabusExamScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<SyllabusExam> _exams = []; // Local list of exams for real-time updates

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'exams' table
    _supabase
        .from('syllabus_exams')
        .stream(primaryKey: ['id']) // Specify the primary key
        .eq('syllabus_id', widget.syllabus.id) // Filter by topic_id
        .execute()
        .listen((data) {
      setState(() {
        _exams = data.map((e) => SyllabusExam.fromMap(e)).toList();
      });
    });

    // Initial fetch of exams
    _fetchInitialExams();
  }

  Future<void> _fetchInitialExams() async {
    final response = await _supabase
        .from('exams')
        .select()
        .eq('topic_id', widget.syllabus.id) // Filter by topic_id
        .execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching exams: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _exams = (response.data as List<dynamic>)
          .map((e) => SyllabusExam.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.syllabus.name)),
      body: _exams.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loader while data is fetched
          : ListView.builder(
        itemCount: _exams.length,
        itemBuilder: (context, index) {
          final SyllabusExam exam = _exams[index];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SyllabusExamDetailScreen(exam: exam),
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
