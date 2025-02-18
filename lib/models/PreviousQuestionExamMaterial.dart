import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousQuestionExamMaterial {

  int id;
  String url;
  String name;
  final int previous_question_exam_id;

  PreviousQuestionExamMaterial({
    required this.id,
    required this.url,
    required this.name,
    required this.previous_question_exam_id
  });

  factory PreviousQuestionExamMaterial.fromMap(Map<String, dynamic> map) {
    return PreviousQuestionExamMaterial(
      id: map['id'],
      url: map['url'] as String,
      name: map['name'] as String,
      previous_question_exam_id: map['previous_question_exam_id'],
    );
  }
}