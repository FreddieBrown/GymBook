import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'FormMaker.dart';

class newRoutine extends StatefulWidget {
  @override
  newRoutineState createState() => newRoutineState();
}

class newRoutineState extends State<newRoutine> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  var form = FormMaker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Routine"),
      ),
      body: Form(
        key: _formKey,
        child: form.form(
            [
              "Routine Name",
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
      floatingActionButton: FloatingActionButton(
        heroTag: "Routine1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            if (_formKey.currentState.validate()) {
              Navigator.pop(context, controller1.text);
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