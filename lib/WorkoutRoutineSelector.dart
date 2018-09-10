import 'package:flutter/material.dart';
import 'Models/Routine.dart';
import 'database/db.dart';
import 'dart:async';
import 'Models/Workout.dart';
import 'Models/ExerciseData.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);
class WorkoutRoutineSelector extends StatefulWidget{
  String name;
  WorkoutRoutineSelector(this.name);
  @override
  WorkoutRoutineSelectorState createState() => WorkoutRoutineSelectorState(name);
}

class WorkoutRoutineSelectorState extends State<WorkoutRoutineSelector>{
  String name;
  WorkoutRoutineSelectorState(this.name);
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
              return new Text('Error: ${snapshot.error}');
            else
              return _routines(context, snapshot);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a routine'),
        centerTitle: true,
      ),
        body: Center(
          child: fut,
        ),
    );
  }

  Widget _routines(BuildContext context, AsyncSnapshot snapshot){
    var ra = snapshot.data;
    var _length = ra.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _routine(ra[index]);
        }
    );
  }

  Widget _routine(Routine r){
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          title: Text(
            r.name,
            style: _biggerFont,
          ),
          subtitle: Text(
            "ID: ${r.id}",
          ),
          trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.white),
          onTap: () async {
              if('$name' != 'null') {
                try {
                  var date = DateTime.now();
                  await db.get().updateWorkout(
                      Workout(
                          name: name,
                          routine: r.id,
                          date: '$date'));
                  List w = await db.get().getWorkoutByDate('$date');
                  Workout work = w[0];
                  List dataE = await exercises(r);
                  for(int j = 0; j < dataE.length; j++){
                    if(dataE[j].flag == 0){
                      db.get().updateExerciseData(
                          ExerciseData(
                              workout: work.id,
                              exercise: dataE[j].id,
                              sets: 0,
                              reps: 0,
                              weight: 0.0
                          )
                      );
                    }
                    else{
                      db.get().updateExerciseData(
                          ExerciseData(
                            workout: work.id,
                            exercise: dataE[j].id,
                            distance: 0.0,
                            time: 0.0,
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
      )
    );
  }

  Future<List<Routine>> data() async{
    var list;
    try {
      list = await db.get().getRoutines();
    }
    catch(e){
      print(e.toString());
    }
    return list;
  }

  Future<List> exercises(Routine routine) async{
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