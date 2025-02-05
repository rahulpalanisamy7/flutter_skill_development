import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {

  String documentId;
  String name;

  Topic({
    required this.documentId,
    required this.name
  });

  // Factory constructor to create a Topic object from Firestore document data
  factory Topic.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Topic(
      documentId: doc.id, // Get the document ID
      name: doc['name'] ?? 'Unknown', // Get the name from document or use 'Unknown'
    );
  }
}