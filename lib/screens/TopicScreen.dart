import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/Topic.dart';
import 'ExamScreen.dart';

class TopicScreen extends StatefulWidget {

  final String title;

  const TopicScreen({super.key, required this.title});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  final CollectionReference _topicCollection = FirebaseFirestore.instance.collection('topic');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: StreamBuilder<QuerySnapshot>(
        stream: _topicCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];

          // Convert documents to Topic model instances
          final List<Topic> topics = documents.map((doc) => Topic.fromDocumentSnapshot(doc)).toList();

          return ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final Topic row = topics[index];

              return ListTile(
                title: Text(row.name), // Use the name from the Topic model
                onTap: () {
                  // Pass the Topic model instance to the TopicDetailScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamScreen(topic: row),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}