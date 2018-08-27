import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';

class newRoutine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Routine"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Routine1",
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