import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;

  ExerciseDetail({Key key, @required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Text(
            '${exercise.name}',
            style: const TextStyle(fontSize: 26.0),
          ),
          Text(
            '${exercise.notes}',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          db.get().removeExercise(exercise.id);
          Navigator.pop(context);
        },
      ),
    );
  }
}