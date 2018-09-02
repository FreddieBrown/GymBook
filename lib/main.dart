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

final _biggerFont = const TextStyle(fontSize: 18.0);
void main() async{
  var work = [
    new Workout(id: 1, routine: 1, name: "Workout1", date: '${DateTime.now()}'),
    new Workout(id: 2, routine: 2, name: "Workout2", date: '${DateTime.now()}'),
    new Workout(id: 3, routine: 1, name: "Workout3", date: '${DateTime.now()}'),
    new Workout(id: 4, routine: 2, name: "Workout4", date: '${DateTime.now()}'),
  ];

  List exe= [
    new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight"),
    new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor"),
    new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest"),
    new Exercise(name: "Running", id: 4, notes: "Just Run"),
  ];

  List rea = [
    new RoutineExercise(routine: 1, exercise: 1),
    new RoutineExercise(routine: 1, exercise: 4),
    new RoutineExercise(routine: 2, exercise: 2),
    new RoutineExercise(routine: 2, exercise: 3),
    new RoutineExercise(routine: 2, exercise: 4)
  ];

  List ra = [
    new Routine(name: "Routine1", id: 1),
    new Routine(name: "Routine2", id: 2)
  ];

  List workouts = [];
  db data = db.get();
  try {
    await data.init();
    db.get().data.delete("Workouts");
    db.get().data.delete("Routines");
    db.get().data.delete("Exercises");
    db.get().data.delete("RoutineExercises");
    db.get().data.delete("ExerciseData");
    await data.init();
  }
  catch(e){
    print(e.toString());
  }

  work.forEach((element){
    db.get().updateWorkout(element);
  });
  exe.forEach((element){
    db.get().updateExercise(element);
  });
  rea.forEach((element){
    db.get().updateRoutineExercise(element);
  });
  ra.forEach((element){
    db.get().updateRoutine(element);
  });

  workouts = await db.get().getWorkouts();
  List routines = await db.get().getRoutines();
  List exercises = await db.get().getExercises();
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
