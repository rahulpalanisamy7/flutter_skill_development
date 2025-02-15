import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/ExamDetailScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/Topic.dart';
import '../models/Exam.dart';

class ExamScreen extends StatefulWidget {
  final Topic topic;

  const ExamScreen({super.key, required this.topic});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<Exam> _exams = []; // Local list of exams for real-time updates

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'exams' table
    _supabase
        .from('exams')
        .stream(primaryKey: ['id']) // Specify the primary key
        .eq('topic_id', widget.topic.id) // Filter by topic_id
        .execute()
        .listen((data) {
      setState(() {
        _exams = data.map((e) => Exam.fromMap(e)).toList();
      });
    });

    // Initial fetch of exams
    _fetchInitialExams();
  }

  Future<void> _fetchInitialExams() async {
    final response = await _supabase
        .from('exams')
        .select()
        .eq('topic_id', widget.topic.id) // Filter by topic_id
        .execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching exams: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _exams = (response.data as List<dynamic>)
          .map((e) => Exam.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.name)),
      body: _exams.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loader while data is fetched
          : ListView.builder(
        itemCount: _exams.length,
        itemBuilder: (context, index) {
          final Exam exam = _exams[index];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExamDetailScreen(exam: exam),
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
