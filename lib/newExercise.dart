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
  var flag = 0;


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
        child: ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            Text(
              "Exercise Name",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                validator: _valid,
                keyboardType: TextInputType.number,
                controller: controller1,
                maxLines: 1,
                maxLength: 30,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Exercise Name"
                ),
              ),
            ),
            Text(
              "Notes",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: null,
                controller: controller2,
                maxLines: null,
                maxLength: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Notes"
                ),
              ),
            ),
            RadioListTile(
                title: Text("Cardio?"),
                value: 1,
                groupValue: flag,
                onChanged: (int fl){
                 setState(() {
                   flag = fl;
                   print(flag);
                 });
                }
                ),
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
                  {"name": controller1.text, "notes": controller2.text, "flag": flag});
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


