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
  Routine routine;
  String name;

  ExerciseDataSelector(this.routine, this.name);
  @override
  ExerciseDataSelectorState createState() => ExerciseDataSelectorState(routine, name);
}

class ExerciseDataSelectorState extends State<ExerciseDataSelector>{
  List<TextEditingController> controllers = <TextEditingController>[];
  Routine routine;
  String name;
  List dataE;
  DateTime date = DateTime.now();
  var future;
  final _formKey = GlobalKey<FormState>();
  ExerciseDataSelectorState(this.routine, this.name);

  @override
  void initState() {
    super.initState();
    future = data();
  }

  @override
  Widget build(BuildContext context) {
    var fut = FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('Press button to start.');
          case ConnectionState.active:
            return new Text('Active');
          case ConnectionState.waiting:
            return new Center(
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 7.0,
                ));
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text('No Exercises, try adding some to the routine');
            else if(snapshot.data.length == 0){
              return Text("You don't have any exercises, try creating one and then comeback!");
            }
            else
              return _routines(context, snapshot);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('What are you doing?'),
      ),
      body: Center(
        child: fut,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              var datas = [];
              controllers.forEach((controller){
                datas.add(controller.text);
              });
              print('Datas length: ${datas.length}');
              for(int j = 0; j < datas.length; j++){
                print(datas[j]);
              }
              try {
                await db.get().updateWorkout(
                    Workout(
                        name: name,
                        routine: routine.id,
                        date: '$date'));
                var w = await db.get().getWorkoutByDate('$date');
                var work = w[0];
                int ind = 0;
                for(int j = 0; j < dataE.length; j++){
                  if(dataE[j].flag == 0){
                    db.get().updateExerciseData(
                        ExerciseData(
                          workout: work.id,
                          exercise: dataE[j].id,
                          sets: int.parse(datas[ind++]),
                          reps: int.parse(datas[ind++]),
                          weight: double.parse(datas[ind++])
                        )
                    );
                  }
                  else{
                    db.get().updateExerciseData(
                        ExerciseData(
                            workout: work.id,
                            exercise: dataE[j].id,
                            distance: double.parse(datas[ind++]),
                            time: double.parse(datas[ind++]),
                        )
                    );
                  }
                }
              }
              catch (e) {
                print(e.toString());
              }
              Navigator.popUntil(context, ModalRoute.withName('/'));
            }
          },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    controllers.forEach((c){
      c.dispose();
    });
    super.dispose();
  }

  _routines(BuildContext context, AsyncSnapshot snapshot){
    dataE = snapshot.data;
    int num = 0;
    controllers = [];
    dataE.forEach((da){
      if(da.flag == 0){
        num += 3;
      }
      else{
        num += 2;
      }
    });
    for(int j = 0; j < num; j++){
      var c = TextEditingController();
      controllers.add(c);
    };
    var hold;
    int cindex = 0;
    return Form(key: _formKey,
      child: ListView.builder(padding: const EdgeInsets.all(8.0),
        itemCount: dataE.length*3,
        itemBuilder: (context, i) {
          if(i % 3 == 2){
            return new Divider();
          }
          else if(i % 3 == 1){
            /// Need to use controllers here to take in values to create ExerciseData
            if(hold.flag == 0){
            return Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
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
//                    keyboardType: TextInputType.number,
                    controller: controllers[cindex++],
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Sets",
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
//                    keyboardType: TextInputType.number,
                    controller: controllers[cindex++],
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Reps",
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
//                    keyboardType: TextInputType.number,
                    controller: controllers[cindex++],
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Weight (kg)",
                    ),
                  ),
                ),
              ],
            );

            }
            else{
              return Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
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
//                      keyboardType: TextInputType.number,
                      controller: controllers[cindex++],
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Distance (km)",
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
//                      keyboardType: TextInputType.number,
                      controller: controllers[cindex++],
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Time (mins)",
                      ),
                    ),
                  ),
                ],
              );
            }

          }
          else{
            final index = i ~/ 3;
            hold = dataE[index];
            return _routine(dataE[index]);
          }
        }));
  }

  _routine(Exercise e){
    return ListTile(
      title: Text(e.name),
    );
  }

  data() async{
    var list = [];
    try {
      var list1 = await db.get().getREByRoutine('${routine.id}');
      list1.forEach((re)async{
        list.add(await db.get().getExercise('${re.exercise}'));
      });
      await new Future.delayed(Duration(milliseconds: 50));

    }
    catch(e){
      print(e.toString());
    }
    return list;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}