import 'package:flutter/material.dart';
import 'database/db.dart';
import 'Models/Exercise.dart';
import 'Help.dart';

class Set extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget{
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 122.0, right: 122.0),
                  child: Text("Help", style: const TextStyle(color: Colors.white)),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
              },
            ),
              GestureDetector(
                child: Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 102.0, right: 102.0),
                    child: Text("Reset Data", style: const TextStyle(color: Colors.white)),
                  ),
                ),
                onTap: () {
                  setState(() {
                    reset();
                  });
                },
              ),
          ],
        )
      )
    );
  }

  reset() async{
    db data = db.get();
    await db.get().data.delete("Workouts");
    await db.get().data.delete("Routines");
    await db.get().data.delete("Exercises");
    await db.get().data.delete("RoutineExercises");
    await db.get().data.delete("ExerciseData");
    await db.get().data.delete("users");
    await data.init();

    List exe= [
      new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight", flag: 0),
      new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor", flag: 0),
      new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest", flag: 0),
      new Exercise(name: "Running", id: 4, notes: "Just Run", flag: 1),
    ];

    exe.forEach((element) async{
      await db.get().updateExercise(element);
    });

    Navigator.popUntil(context, ModalRoute.withName('/'));

  }
}