class VideoTutorial {

  int id;
  String name;
  String url;

  VideoTutorial({
    required this.id,
    required this.name,
    required this.url,
  });

  factory VideoTutorial.fromMap(Map<String, dynamic> map) {
    return VideoTutorial(
      id: map['id'],
      name: map['name'],
      url: map['url']
    );
  }
}