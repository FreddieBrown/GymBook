import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'FormMaker.dart';

class newExercise extends StatefulWidget {
  @override
  newExerciseState createState() => newExerciseState();
}

class newExerciseState extends State<newExercise> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  var form = FormMaker();


  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exercise"),
      ),
      body: Form(
        key: _formKey,
        child: form.form(
            [
              "Exercise Name",
              "Notes",
            ],
            [
              controller1,
              controller2
            ],
            [
              1,
              null
            ],
            [
              30,
              null
            ],
          [
            _valid,
            null
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Exercise1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            if (_formKey.currentState.validate()) {
              Navigator.pop(context,
                  {"name": controller1.text, "notes": controller2.text});
            }
          },
          child: Icon(Icons.save),
      ),
    );
  }
}

String _valid(value){
  print(value);
  if (value.isEmpty) {
    return 'Please enter some text';
  }
}