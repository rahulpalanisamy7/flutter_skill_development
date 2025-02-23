class Syllabus {
  final int id;
  final String name;

  Syllabus({required this.id, required this.name});

  factory Syllabus.fromMap(Map<String, dynamic> map) {
    return Syllabus(
      id: map['id'],
      name: map['name'] as String,
    );
  }
}
