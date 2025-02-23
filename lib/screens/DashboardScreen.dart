import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String title;

  const DashboardScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          TaskCardButton(title: 'TNPSC', progress: 0.6, image_path: "assets/carousel/d1.jpg",),
          TaskCardButton(title: 'UPSC', progress: 0.8, image_path: "assets/carousel/d2.jpg",),
          TaskCardButton(title: 'RRB', progress: 0.4, image_path: "assets/carousel/RRB.jpg",),
          TaskCardButton(title: 'SSC', progress: 0.2, image_path: "assets/carousel/d4.jpg",),
          TaskCardButton(title: 'IBPS', progress: 0.3, image_path: "assets/carousel/IBPS.jpg",),
          TaskCardButton(title: 'DEFENCE', progress: 0.9, image_path: "assets/carousel/DEFENCE.png",),
        ],
      ),
    );
  }
}

class TaskCardButton extends StatelessWidget {
  final String title;
  final double progress;
  final String image_path;

  const TaskCardButton({required this.title, required this.progress, required this.image_path});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Image(
                image: AssetImage(image_path), // Provide the correct path to your image asset
                width: 50, // Adjust width as needed
                height: 50, // Adjust height as needed
              ),
              SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
