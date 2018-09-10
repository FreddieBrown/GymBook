import 'package:flutter/material.dart';
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
  var b = false;


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
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.pop(context,
                  {"name": controller1.text, "notes": controller2.text, "flag": flag});
            }
          }, color: Colors.white
      ),
    ]
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                  "Exercise Name",
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
                ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                validator: _valid,
                controller: controller1,
                autofocus: true,
                maxLines: 1,
                maxLength: 30,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(),
                    hintText: "Exercise Name"
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                "Notes",
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                validator: null,
                controller: controller2,
                maxLines: null,
                maxLength: null,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(),
                    hintText: "Notes"
                ),
              ),
            ),
            SwitchListTile(
                title: Text("Cardio?"),
                value: b,
                onChanged: (bool v){
                 setState(() {
                   b = v;
                   flag = 1;
                 });
                }
                ),
          ]
        ),
      ),
    );
  }
}

String _valid(value){
  if (value.isEmpty) {
    return 'Please enter some text';
  }
}


