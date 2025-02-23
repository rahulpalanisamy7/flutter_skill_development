import 'package:flutter/material.dart';
import 'package:flutter_skill_development/screens/SyllabusExamScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/Syllabus.dart';
import '../widgets/CustomDrawer.dart';
import 'ExamScreen.dart';

class SyllabusScreen extends StatefulWidget {

  final String title;

  const SyllabusScreen({super.key, required this.title});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {

  final SupabaseClient _supabase = Supabase.instance.client;

  List<Syllabus> _syllabus = []; // Local list of topics

  @override
  void initState() {
    super.initState();

    // Listen for real-time updates from the 'topic' table
    _supabase
        .from('syllabus')
        .stream(primaryKey: ['id']) // Specify the primary key
        .execute()
        .listen((data) {
      setState(() {
        _syllabus = data.map((e) => Syllabus.fromMap(e)).toList();
      });
    });


    // Initial fetch of topics
    _fetchInitialSyllabuss();
  }

  Future<void> _fetchInitialSyllabuss() async {
    final response = await _supabase.from('syllabus').select().execute();

    // if (response.error != null) {
    //   // Handle error if needed
    //   print('Error fetching topics: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _syllabus = (response.data as List<dynamic>)
          .map((e) => Syllabus.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(parentContext: context,),
      body: _syllabus.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _syllabus.length,
        itemBuilder: (context, index) {
          final row = _syllabus[index];

          return ListTile(
            title: Text(row.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SyllabusExamScreen(syllabus: row),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
