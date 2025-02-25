import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/VideoTutorial.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class VideoTutorialScreen extends StatefulWidget {
  final String title;

  const VideoTutorialScreen({super.key, required this.title});

  @override
  State<VideoTutorialScreen> createState() => _VideoTutorialScreenState();
}

class _VideoTutorialScreenState extends State<VideoTutorialScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<VideoTutorial> _video_tutorials = []; // Local list of video_tutorials

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'video_tutorial' table
    _supabase
        .from('video_tutorials')
        .stream(primaryKey: ['id']) // Specify the primary key
        .execute()
        .listen((data) {
      setState(() {
        _video_tutorials = data.map((e) => VideoTutorial.fromMap(e)).toList();
      });
    });


    // Initial fetch of video_tutorials
    _fetchInitialVideoTutorials();
  }

  Future<void> _fetchInitialVideoTutorials() async {
    final response = await _supabase.from('video_tutorials').select().execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching video_tutorials: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _video_tutorials = (response.data as List<dynamic>)
          .map((e) => VideoTutorial.fromMap(e as Map<String, dynamic>))
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
      body: _video_tutorials.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _video_tutorials.length,
        itemBuilder: (context, index) {
          final video_tutorial = _video_tutorials[index];

          return ListTile(
            title: Text(video_tutorial.name),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ExamScreen(video_tutorial: video_tutorial),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
