class SyllabusExam {

  int id;
  String name;
  final int syllabus_id;

  SyllabusExam({
    required this.id,
    required this.name,
    required this.syllabus_id
  });

  factory SyllabusExam.fromMap(Map<String, dynamic> map) {
    return SyllabusExam(
      id: map['id'],
      name: map['name'] as String,
      syllabus_id: map['syllabus_id'],
    );
  }
}