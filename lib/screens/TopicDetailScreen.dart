import 'package:flutter/material.dart';
import 'package:flutter_skill_development/models/Topic.dart';

class TopicDetailScreen extends StatefulWidget {

  final Topic topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.name),
      ),
      body: Center(
        child: Text(widget.topic.name),
      ),
    );
  }
}
