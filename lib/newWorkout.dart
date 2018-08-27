import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';

class newWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Workout"),
      ),
      floatingActionButton:FloatingActionButton(
        heroTag: "Workout1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            print("Saved");
            Navigator.pop(context, "Saved!");
          },
          child: Icon(Icons.save),
        ),
    );
  }
}