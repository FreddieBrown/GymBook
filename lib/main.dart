import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';
import 'Home.dart';
import 'database/db.dart';
import 'Models/Workout.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);
void main() async{
  var work = [
    new Workout(id: 1, name: "Workout1", date: '${DateTime.now()}'),
    new Workout(id: 2, name: "Workout2", date: '${DateTime.now()}'),
    new Workout(id: 3, name: "Workout3", date: '${DateTime.now()}'),
    new Workout(id: 4, name: "Workout4", date: '${DateTime.now()}'),
  ];
  List workouts = [];
  db data = db.get();
  try {
    await data.init();
//    db.get().data.delete("Workouts");
//    db.get().data.delete("Routines");
//    db.get().data.delete("Exercises");
//    db.get().data.delete("RoutineExercises");
//    await data.init();
  }
  catch(e){
    print(e.toString());
  }

  work.forEach((element){
    db.get().updateWorkout(element);
  });
  workouts = await db.get().getWorkouts();
  List routines = await db.get().getRoutines();
  List exercises = await db.get().getExercises();
  print(workouts[0].date);
  runApp(new GymBook());
}

class GymBook extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
