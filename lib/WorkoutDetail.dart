import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
class WorkoutDetail extends StatelessWidget {
  final String name;

  WorkoutDetail({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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