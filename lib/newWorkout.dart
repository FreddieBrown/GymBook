import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      body: Form(
        key: _formKey,
        child: form.form(
            [
              "Workout Name",
            ],
            [
              controller1,
            ],
            [
              1,
            ],
            [
              30,
            ],
            [
              _valid,
            ]
        ),
      ),
      floatingActionButton:FloatingActionButton(
        heroTag: "Workout1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            if (_formKey.currentState.validate()) {
              print("Saved");
              Navigator.pop(context, controller1.text);
            }
          },
          child: Icon(Icons.save),
        ),
    );
  }
}

String _valid(value){
  if (value.isEmpty) {
    return 'Please enter some text';
  }
}