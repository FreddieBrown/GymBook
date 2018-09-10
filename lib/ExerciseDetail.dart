import 'package:flutter/material.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';
import 'GymButton.dart';

class ExerciseDetail extends StatelessWidget {
  final Exercise exercise;

  ExerciseDetail({Key key, @required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var flag;
    if(exercise.flag == 1){
      flag = "Cardio";
    }
    else{
      flag = "Weights";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Center(
            child: Text(
              '${exercise.name}',
              style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
                  'Notes',
                  style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                '${exercise.notes}',
                style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            child: Text(
              'Exercise Type',
              style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              flag,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          GymButton(
              func:() {
                db.get().removeExercise(exercise.id);
                Navigator.pop(context);
              },
              text: Text("Delete Exercise", style: const TextStyle(color: Colors.white))
          ),
        ],
      ),
    );
  }
}