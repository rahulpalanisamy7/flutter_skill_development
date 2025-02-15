import 'package:cloud_firestore/cloud_firestore.dart';

class ExamMaterial {

  int id;
  String url;
  String name;
  final int exam_id;

  ExamMaterial({
    required this.id,
    required this.url,
    required this.name,
    required this.exam_id
  });

  factory ExamMaterial.fromMap(Map<String, dynamic> map) {
    return ExamMaterial(
      id: map['id'],
      url: map['url'] as String,
      name: map['name'] as String,
      exam_id: map['exam_id'],
    );
  }
}