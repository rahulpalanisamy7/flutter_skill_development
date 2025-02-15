import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {

  int id;
  String name;
  final int topic_id;

  Exam({
    required this.id,
    required this.name,
    required this.topic_id
  });

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'],
      name: map['name'] as String,
      topic_id: map['topic_id'],
    );
  }
}