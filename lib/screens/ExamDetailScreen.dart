import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Exam.dart';
import '../models/ExamMaterial.dart';

class ExamDetailScreen extends StatefulWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  @override
  State<ExamDetailScreen> createState() => _ExamDetailScreenState();
}

class _ExamDetailScreenState extends State<ExamDetailScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<ExamMaterial> _materials = [];

  @override
  void initState() {
    super.initState();
    _fetchExamMaterials();
  }

  Future<void> _fetchExamMaterials() async {
    final response = await _supabase
        .from('exam_materials')
        .select()
        .eq('exam_id', widget.exam.id) // Filter materials by exam_id
        .execute();

    // if (response.error != null) {
    //   // Handle error
    //   print('Error fetching materials: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _materials = (response.data as List<dynamic>)
          .map((e) => ExamMaterial.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> _downloadPdf(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.name),
      ),
      body: _materials.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _materials.length,
        itemBuilder: (context, index) {
          final ExamMaterial material = _materials[index];

          return ListTile(
            title: Text('Material ${material.id}'),
            subtitle: Text(material.url),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () => _downloadPdf(material.url), // Download the PDF
            ),
          );
        },
      ),
    );
  }
}
