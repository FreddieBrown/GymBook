import 'package:flutter/material.dart';
import 'FormMaker.dart';
import 'Models/Routine.dart';
import 'database/db.dart';


class newRoutine extends StatefulWidget {
  var id;
  newRoutine(this.id);
  @override
  newRoutineState createState() => newRoutineState(id);
}

class newRoutineState extends State<newRoutine> {
  final _formKey = GlobalKey<FormState>();
  final controller1 = TextEditingController();
  var form = FormMaker();
  int id;

  newRoutineState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Routine"),
        centerTitle: true,
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
            ],
            [
              true
            ]

        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Routine1",
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            if (_formKey.currentState.validate()) {
              var routine;
              try {
                routine = Routine(name: controller1.text, user: id);
              }
              catch(e){
                print(e.toString());
              }
              db.get().updateRoutine(routine);
              setState(() {
                Navigator.pop(context);
              });
            }
          },
          child: Icon(Icons.save, color: Colors.white),
        ),
    );
  }
}

String _valid(value){
  if (value.isEmpty) {
    return 'Please enter some text';
  }
}