import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/SyllabusExam.dart';
import '../models/SyllabusExamMaterial.dart';
import 'PDFViewerScreen.dart';

class SyllabusExamDetailScreen extends StatefulWidget {
  final SyllabusExam exam;

  const SyllabusExamDetailScreen({super.key, required this.exam});

  @override
  State<SyllabusExamDetailScreen> createState() => _SyllabusExamDetailScreenState();
}

class _SyllabusExamDetailScreenState extends State<SyllabusExamDetailScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<SyllabusExamMaterial> _materials = [];

  @override
  void initState() {
    super.initState();
    _fetchSyllabusExamMaterials();
  }

  Future<void> _fetchSyllabusExamMaterials() async {
    final response = await _supabase
        .from('syllabus_exam_materials')
        .select()
        .eq('syllabus_exam_id', widget.exam.id) // Filter materials by exam_id
        .execute();

    // if (response.error != null) {
    //   print('Error fetching materials: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _materials = (response.data as List<dynamic>)
          .map((e) => SyllabusExamMaterial.fromMap(e as Map<String, dynamic>))
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
          final SyllabusExamMaterial material = _materials[index];

          return ListTile(
            // title: Text('Material ${material.id}'),
            title: Text(material.name),
            // subtitle: Text(material.url),
            trailing: const Icon(Icons.picture_as_pdf),
            onTap: () {
              // Navigate to the PDF Viewer Screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         PDFViewerScreen(pdfUrl: material.url),
              //   ),
              // );

              _downloadPdf(material.url);
            },
          );
        },
      ),
    );
  }
}
