class SyllabusExamMaterial {

  int id;
  String url;
  String name;
  final int syllabus_exam_id;

  SyllabusExamMaterial({
    required this.id,
    required this.url,
    required this.name,
    required this.syllabus_exam_id
  });

  factory SyllabusExamMaterial.fromMap(Map<String, dynamic> map) {
    return SyllabusExamMaterial(
      id: map['id'],
      url: map['url'] as String,
      name: map['name'] as String,
      syllabus_exam_id: map['syllabus_exam_id'],
    );
  }
}