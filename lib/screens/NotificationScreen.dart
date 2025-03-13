import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/NotificationModel.dart';

class NotificationScreen extends StatefulWidget {
  final String title;

  const NotificationScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();

    // Listen for real-time updates from Supabase
    _supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false) // Order by newest first
        .listen((data) {
      setState(() {
        _notifications = data.map((e) => NotificationModel.fromMap(e)).toList();
      });
    });
  }

  Future<void> _fetchNotifications() async {
    try {
      final response = await _supabase
          .from('notifications')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        _notifications =
            (response as List<dynamic>).map((e) => NotificationModel.fromMap(e)).toList();
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching notifications: $error');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CustomDrawer(parentContext: context,),
      body: _notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(

            padding: const EdgeInsets.all(16.0),
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
            final row = _notifications[index];

            return Column(
              children: [
                NotificationCard(
                  icon: Icons.payment,
                  title: row.title,
                  subtitle: row.subtitle,
                  time: row.timeAgo ?? 'Just now',
                ),
              ],
            );
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}