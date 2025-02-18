class PreviousQuestion {
  final int id;
  final String name;

  PreviousQuestion({required this.id, required this.name});

  factory PreviousQuestion.fromMap(Map<String, dynamic> map) {
    return PreviousQuestion(
      id: map['id'],
      name: map['name'] as String,
    );
  }
}
