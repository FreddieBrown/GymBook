import 'package:flutter/material.dart';
import 'FormMaker.dart';
import 'WorkoutRoutineSelector.dart';
import 'GymPageRoute.dart';

class newWorkout extends StatefulWidget {
  @override
  newWorkoutState createState() => newWorkoutState();
}

/// In this need to add in attaching a routine to a workout.

class newWorkoutState extends State<newWorkout> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  var form = FormMaker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Workout"),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: form.form([
            "Workout Name",
          ], [
            controller1,
          ], [
            1,
          ], [
            30,
          ], [
            _valid,
          ], [
            true
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Workout1",
        onPressed: () async {
          // Navigate back to the first screen by popping the current route
          // off the stack
          if (_formKey.currentState.validate()) {
//              Navigator.pop(context, controller1.text);
            await Navigator.push(
              context,
              GymPageRoute(
                  builder: (context) =>
                      WorkoutRoutineSelector(controller1.text)),
            );
          }
        },
        child: Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}

String _valid(value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
}
