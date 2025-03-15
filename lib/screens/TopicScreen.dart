import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/Topic.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class TopicScreen extends StatefulWidget {
  final String title;

  const TopicScreen({super.key, required this.title});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Topic> _topics = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'topics' table
    _supabase.from('topics').stream(primaryKey: ['id']).execute().listen((data) {
      if (mounted) {
        setState(() {
          _topics = data.map((e) => Topic.fromMap(e)).toList();
          _isLoading = false;
        });
      }
    });

    // Initial fetch of topics
    _fetchInitialTopics();
  }

  Future<void> _fetchInitialTopics() async {
    try {
      final response = await _supabase.from('topics').select().execute();
      if (mounted) {
        setState(() {
          _topics = (response.data as List<dynamic>)
              .map((e) => Topic.fromMap(e as Map<String, dynamic>))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching topics: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(parentContext: context),
      body: _isLoading
          ? _buildLoadingShimmer()
          : _topics.isEmpty
          ? _buildEmptyState()
          : _buildTopicList(),
    );
  }

  /// Builds the topic list
  Widget _buildTopicList() {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: _topics.length,
      separatorBuilder: (_, __) => const Divider(thickness: 1),
      itemBuilder: (context, index) {
        final topic = _topics[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            leading: CircleAvatar(
              backgroundColor: Color(0xffB81736),
              child: Text(
                topic.name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              topic.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExamScreen(topic: topic)),
              );
            },
          ),
        );
      },
    );
  }

  /// Displays a shimmer effect while loading
  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const ListTile(
              leading: CircleAvatar(backgroundColor: Colors.white),
              title: SizedBox(height: 15, width: 100, child: DecoratedBox(decoration: BoxDecoration(color: Colors.white))),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  /// Displays a message when no topics are available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          Text(
            "No topics available",
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
