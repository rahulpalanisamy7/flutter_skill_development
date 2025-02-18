import 'package:flutter/material.dart';
import 'package:flutter_skill_development/models/PreviousQuestionExamMaterial.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/PreviousQuestionExam.dart';
import '../models/ExamMaterial.dart';
import 'PDFViewerScreen.dart';

class PreviousQuestionExamDetailScreen extends StatefulWidget {
  final PreviousQuestionExam previous_question_exam;

  const PreviousQuestionExamDetailScreen({super.key, required this.previous_question_exam});

  @override
  State<PreviousQuestionExamDetailScreen> createState() => _PreviousQuestionExamDetailScreenState();
}

class _PreviousQuestionExamDetailScreenState extends State<PreviousQuestionExamDetailScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<PreviousQuestionExamMaterial> _materials = [];

  @override
  void initState() {
    super.initState();
    _fetchExamMaterials();
  }

  Future<void> _fetchExamMaterials() async {
    final response = await _supabase
        .from('previous_question_exam_materials')
        .select()
        .eq('previous_question_exam_id', widget.previous_question_exam.id) // Filter materials by exam_id
        .execute();

    // if (response.error != null) {
    //   print('Error fetching materials: ${response.error?.message}');
    //   return;
    // }

    setState(() {
      _materials = (response.data as List<dynamic>)
          .map((e) => PreviousQuestionExamMaterial.fromMap(e as Map<String, dynamic>))
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
        title: Text(widget.previous_question_exam.name),
      ),
      body: _materials.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _materials.length,
        itemBuilder: (context, index) {
          final PreviousQuestionExamMaterial material = _materials[index];

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
