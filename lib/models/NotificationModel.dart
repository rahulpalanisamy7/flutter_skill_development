import 'package:timeago/timeago.dart' as timeago;

class NotificationModel {
  final int id;
  final String title;
  final String subtitle;
  final DateTime createdAt; // Store as DateTime

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
  });

  // Convert createdAt to "5 min ago" format
  String get timeAgo => timeago.format(createdAt);

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      createdAt: DateTime.parse(map['created_at'] as String), // Convert String to DateTime
    );
  }
}
