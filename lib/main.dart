import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';
import 'Home.dart';
import 'database/db.dart';
import 'Models/Workout.dart';
import 'Models/Exercise.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/ExerciseData.dart';

void main() async{

  List exe= [
    new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight", flag: 0),
    new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor", flag: 0),
    new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest", flag: 0),
    new Exercise(name: "Running", id: 4, notes: "Just Run", flag: 1),
  ];

  db data = db.get();
  try {
    await data.init();
//    db.get().data.delete("Workouts");
//    db.get().data.delete("Routines");
//    db.get().data.delete("Exercises");
//    db.get().data.delete("RoutineExercises");
//    db.get().data.delete("ExerciseData");
//    await data.init();
  }
  catch(e){
    print(e.toString());
  }

  exe.forEach((element) async{
    await db.get().updateExercise(element);
  });
  runApp(new GymBook());
}

class GymBook extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'Gym Book',
      theme: new ThemeData(
//        primarySwatch: Colors.white,// Add the 3 lines from here...
        primaryColor: Colors.white,
        accentColor: Colors.blueGrey,
//        dividerColor: Colors.red,
      ),
//      home: new MyHomePage(title: 'GymBook'),
//        home: new homeList(),
      home: DefaultTabController(
        length: 3,
        child: Home(),
      ),
    );
  }
}
