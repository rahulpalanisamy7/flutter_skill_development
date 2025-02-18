import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousQuestionExam {

  int id;
  String name;
  final int previous_question_id;

  PreviousQuestionExam({
    required this.id,
    required this.name,
    required this.previous_question_id
  });

  factory PreviousQuestionExam.fromMap(Map<String, dynamic> map) {
    return PreviousQuestionExam(
      id: map['id'],
      name: map['name'] as String,
      previous_question_id: map['previous_question_id'],
    );
  }
}