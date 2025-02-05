import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/Topic.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('topic');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore ListView')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];

          // Convert documents to Topic model instances
          final List<Topic> countries = documents.map((doc) => Topic.fromDocumentSnapshot(doc)).toList();

          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final Topic row = countries[index];

              return ListTile(
                title: Text(row.name), // Use the name from the Topic model
                onTap: () {
                  // Pass the Topic model instance to the TopicDetailScreen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TopicDetailScreen(row: row),
                  //   ),
                  // );
                },
              );
            },
          );
        },
      ),
    );
  }
}