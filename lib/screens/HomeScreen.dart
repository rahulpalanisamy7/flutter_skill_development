 import 'package:flutter/material.dart';
import 'package:flutter_skill_development/widgets/CustomDrawer.dart';

class HomeScreen extends StatefulWidget {

  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){

           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                 content: Text("Menu Works")
             )
           );

          },
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              color: Colors.amber,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.pink,
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.blueGrey,
            )
          ],
        ),




        ),
      
    );
  }
}
