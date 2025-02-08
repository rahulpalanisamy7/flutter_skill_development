import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {

  String documentId;
  String name;
  final DocumentReference topicRef;

  Exam({
    required this.documentId,
    required this.name,
    required this.topicRef
  });

  factory Exam.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exam(
      documentId: doc.id,
      name: data['name'] ?? '',
      topicRef: data['topic_id'], // Firestore reference to the topic
    );
  }
}