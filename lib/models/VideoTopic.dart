class VideoTopic {
  final int id;
  final String name;

  VideoTopic({required this.id, required this.name});

  factory VideoTopic.fromMap(Map<String, dynamic> map) {
    return VideoTopic(
      id: map['id'],
      name: map['name'] as String,
    );
  }
}
