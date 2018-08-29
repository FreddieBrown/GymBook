import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';
import 'Models/Workout.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Exercise.dart';

class Home extends StatelessWidget{
  final _work = Runes(' \u{1F3CB} ');
  final _work1 = Runes('\u{1F501}');
  final _work2 = Runes('\u{1F938}');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(text: "Workouts "+String.fromCharCodes(_work)),
            Tab(text: "Routines "+String.fromCharCodes(_work1)),
            Tab(text: "Exercises "+String.fromCharCodes(_work2)),
          ],
        ),
        title: Text('GymBook'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: Icon(Icons.list),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              }
          ),
        ],
      ),
      body: TabBarView(
        children: [
          WorkoutList(),
          RoutineList(),
          ExercisesList(),
        ],
      ),
    );
  }
}