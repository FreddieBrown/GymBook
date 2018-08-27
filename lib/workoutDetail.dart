import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
class workoutDetail extends StatelessWidget {
  final String name;

  workoutDetail({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('$name',
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}