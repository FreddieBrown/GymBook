import 'package:flutter/material.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';

class ExerciseSelector extends StatefulWidget{

  @override
  ExerciseSelectorState createState() => ExerciseSelectorState();
}

class ExerciseSelectorState extends State<ExerciseSelector>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Select an Exercise"),
      ),
    );
  }

  ///Build a list of all Exercises in the database
  /// Allow a user to select one of them
  /// Pass that exercise back to the RoutineBuilder with a list which includes
  /// the new exercise.
}