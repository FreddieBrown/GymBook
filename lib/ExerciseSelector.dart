import 'package:flutter/material.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';

class ExerciseSelector extends StatefulWidget{

  @override
  ExerciseSelectorState createState() => ExerciseSelectorState();
}

class ExerciseSelectorState extends State<ExerciseSelector>{
  List exe = [
    new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight"),
    new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor"),
    new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest"),
    new Exercise(name: "Running", id: 4, notes: "Just Run"),
  ];

  ExerciseSelectorState(){
    data();
  }
  @override
  Widget build(BuildContext context){
    data();
    return Scaffold(
      appBar: AppBar(
        title: Text("Select an Exercise"),
      ),
      body: exercises(),
    );
  }

  ///Build a list of all Exercises in the database
  /// Allow a user to select one of them
  /// Pass that exercise back to the RoutineBuilder with a list which includes
  /// the new exercise.

  Widget exercises(){
    data();
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: exe.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          print(exe[index].name);
          return exercise(exe[index]);
        }
    );
  }

  Widget exercise(Exercise e){
    return ListTile(
      title: Text('${e.name}'),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.pop(context, e);
      },
    );
  }

  data() async{
    try {
      exe.forEach((element) {
        db.get().updateExercise(element);
      });
      exe = await db.get().getExercises();
    }
    catch(e){
      print(e.toString());
    }

  }
}