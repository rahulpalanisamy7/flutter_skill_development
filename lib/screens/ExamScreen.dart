import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skill_development/models/Topic.dart';
import 'package:flutter_skill_development/models/Exam.dart';

class ExamScreen extends StatefulWidget {
  final Topic topic;

  const ExamScreen({super.key, required this.topic});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.name)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('exam')
            .where('topic_id', isEqualTo: FirebaseFirestore.instance.doc('topic/${widget.topic.documentId}')) // Filtering by reference
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];

          if (documents.isEmpty) {
            return Center(child: Text("No exams available for this topic"));
          }

          final List<Exam> exams = documents.map((doc) => Exam.fromDocumentSnapshot(doc)).toList();

          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final Exam row = exams[index];

              return ListTile(
                title: Text(row.name),
              );
            },
          );
        },
      ),
    );
  }
}
