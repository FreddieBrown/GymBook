import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'FormMaker.dart';

class newRoutine extends StatefulWidget {
  @override
  newRoutineState createState() => newRoutineState();
}

class newRoutineState extends State<newRoutine> {
  final controller1 = TextEditingController();
  var form = FormMaker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Routine"),
      ),
      body: form.form([
        "Routine Name",
      ], [
        controller1,
      ], [
        1,
      ], [
        30,
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: "Routine1",
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