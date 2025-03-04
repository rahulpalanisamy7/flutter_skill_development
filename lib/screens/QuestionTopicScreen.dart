import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/QuizScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/Topic.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class QuestionTopicScreen extends StatefulWidget {

  final String title;

  const QuestionTopicScreen({super.key, required this.title});

  @override
  State<QuestionTopicScreen> createState() => _QuestionTopicScreenState();
}

class _QuestionTopicScreenState extends State<QuestionTopicScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<Topic> _topics = []; // Local list of topics

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'topic' table
    _supabase
        .from('questions_topics')
        .stream(primaryKey: ['id']) // Specify the primary key
        .listen((data) {
      setState(() {
        _topics = data.map((e) => Topic.fromMap(e)).toList();
      });
    });


    // Initial fetch of topics
    _fetchInitialTopics();
  }

  Future<void> _fetchInitialTopics() async {
    final response = await _supabase.from('questions_topics').select().execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching topics: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _topics = (response.data as List<dynamic>)
          .map((e) => Topic.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: CustomDrawer(parentContext: context,),
      body: _topics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _topics.length,
        itemBuilder: (context, index) {
          final topic = _topics[index];

          return ListTile(
            title: Text(topic.name),
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => QuizScreen(topic: topic),
              //   ),
              // );

              final response = await _supabase
                  .from('questions')
                  .select()
                  .eq('topic_id', topic.id)
                  .execute();

              final questions = response.data as List<dynamic>;

              if (questions.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No questions available for this topic.')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(topic: topic),
                  ),
                );
              }

            },
          );
        },
      ),
    );
  }
}
