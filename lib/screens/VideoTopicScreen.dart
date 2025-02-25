import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/VideoTutorialScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/VideoTopic.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class VideoTopicScreen extends StatefulWidget {
  final String title;

  const VideoTopicScreen({super.key, required this.title});

  @override
  State<VideoTopicScreen> createState() => _VideoTopicScreenState();
}

class _VideoTopicScreenState extends State<VideoTopicScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<VideoTopic> _video_topics = []; // Local list of video_topics

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'topic' table
    _supabase
        .from('video_topics')
        .stream(primaryKey: ['id']) // Specify the primary key
        .execute()
        .listen((data) {
      setState(() {
        _video_topics = data.map((e) => VideoTopic.fromMap(e)).toList();
      });
    });


    // Initial fetch of video_topics
    _fetchInitialVideoTopics();
  }

  Future<void> _fetchInitialVideoTopics() async {
    final response = await _supabase.from('video_topics').select().execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching video_topics: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _video_topics = (response.data as List<dynamic>)
          .map((e) => VideoTopic.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: CustomDrawer(parentContext: context,),
      body: _video_topics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _video_topics.length,
        itemBuilder: (context, index) {
          final topic = _video_topics[index];

          return ListTile(
            title: Text(topic.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoTutorialScreen(video_topic: topic,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
