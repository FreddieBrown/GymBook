import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
class ExerciseDetail extends StatelessWidget {
  final Map exercise;

  ExerciseDetail({Key key, @required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Text(
            '${exercise['name']}',
            style: const TextStyle(fontSize: 26.0),
          ),
          Text(
            '${exercise['notes']}',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}