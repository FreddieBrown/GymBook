import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'FormMaker.dart';

class newWorkout extends StatefulWidget {
  @override
  newWorkoutState createState() => newWorkoutState();
}

class newWorkoutState extends State<newWorkout> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  var form = FormMaker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Workout"),
      ),
      body: form.form([
        "Workout Name",
      ], [
        controller1,
      ], [
        1,
      ], [
        30,
      ]),
      floatingActionButton:FloatingActionButton(
        heroTag: "Workout1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            print("Saved");
            Navigator.pop(context, controller1.text);
          },
          child: Icon(Icons.save),
        ),
    );
  }
}