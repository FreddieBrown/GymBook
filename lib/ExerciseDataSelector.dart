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
  var controllers = [];
  Routine routine;
  String name;
  ExerciseDataSelectorState(this.routine, this.name);
  @override
  Widget build(BuildContext context) {
    var fut = FutureBuilder(
      future: data(),
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
          onPressed: () {
            try {
              db.get().updateWorkout(
                  Workout(name: name, routine: routine.id, date: '${DateTime.now()}'));
            }
            catch(e){
              print(e.toString());
            }
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
      ),
    );
  }

  _routines(BuildContext context, AsyncSnapshot snapshot){
    List data = snapshot.data;
    int num = 0;
    data.forEach((da){
      if(da.flag == 0){
        num += 3;
      }
      else{
        num += 2;
      }
    });
    for(int j = 0; j < num; j++){
      controllers.add(TextEditingController());
    };
    var hold;
    return ListView.builder(padding: const EdgeInsets.all(8.0),
        itemCount: data.length*3,
        itemBuilder: (context, i) {
          if(i % 3 == 2){
            return new Divider();
          }
          else if(i % 3 == 1){
            /// Need to use controllers here to take in values to create ExerciseData
            if(hold.flag == 0){
              return Text('Weights');

            }
            else{
              return Text('Cardio');
            }

          }
          else{
            final index = i ~/ 3;
            hold = data[index];
            return _routine(data[index]);
          }
        });
  }

  _routine(Exercise e){
    return ListTile(
      title: Text(e.name),
      subtitle: Text('ID: ${e.id}'),
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
}