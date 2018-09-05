import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Workout.dart';
import 'database/db.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Exercise.dart';
import 'Models/ExerciseData.dart';
import 'dart:async';

class ExerciseDataSelector extends StatefulWidget{
  Exercise ex;
  ExerciseData exd;
  Workout work;

  ExerciseDataSelector(this.exd, this.ex, this.work);
  @override
  ExerciseDataSelectorState createState() => ExerciseDataSelectorState(exd, ex, work);
}

class ExerciseDataSelectorState extends State<ExerciseDataSelector>{
  ExerciseData exd;
  Exercise ex;
  Workout work;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  ExerciseDataSelectorState(this.exd, this.ex, this.work);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Exercise Data'),
      ),
      body: Center(
        child: form(context),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              var ed;
              try {
                if (ex.flag == 1) {
                  ed = ExerciseData(id: exd.id,
                      distance: double.parse(controller1.text),
                      time: double.parse(controller2.text),
                      workout: work.id,
                      exercise: ex.id);
                  await db.get().updateExerciseData(ed);
                }
                else {
                  ed = ExerciseData(id: exd.id,
                      sets: int.parse(controller2.text),
                      reps: int.parse(controller1.text),
                      weight: double.parse(controller3.text),
                      workout: work.id,
                      exercise: ex.id);
                  await db.get().updateExerciseData(ed);
                }
              }
              catch(e){
                print(e.toString());
              }
              Navigator.pop(context);
            }
          }
      ),
    );
  }

  Widget form(BuildContext context){
    if(ex.flag == 1){
      return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                '${ex.name}',
              ),
            ),
            Wrap(
              children: <Widget>[
                Container(
                  width: 250.0,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child:TextFormField(
                    autofocus: true,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      else if(!isNumeric(value)){
                        return 'Please enter a numeric value';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: controller1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Distance (km)",
                      hintText: "${exd.distance}km",
                    ),
                  ),
                ),
                Container(
                    width: 250.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: TextFormField(
                      validator: (value){
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        else if(!isNumeric(value)){
                          return 'Please enter a numeric value';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: controller2,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Time (mins)",
                        hintText: "${exd.time}mins",
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      );
    }
    else{
      return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                '${ex.name}',
              ),
            ),
            Wrap(
              children: <Widget>[
                Container(
                  width: 250.0,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child:TextFormField(
                    autofocus: true,
                    validator: (value){
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      else if(!isNumeric(value)){
                        return 'Please enter a numeric value';
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: controller1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Reps",
                      hintText: "${exd.reps}",
                    ),
                  ),
                ),
                Container(
                    width: 250.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: TextFormField(
                      validator: (value){
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        else if(!isNumeric(value)){
                          return 'Please enter a numeric value';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: controller2,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Sets",
                        hintText: "${exd.sets}",
                      ),
                    )
                ),
                Container(
                    width: 250.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: TextFormField(
                      validator: (value){
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        else if(!isNumeric(value)){
                          return 'Please enter a numeric value';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: controller3,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Weight (kg)",
                        hintText: "${exd.weight}kg",
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }


}