import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Workout.dart';
import 'database/db.dart';
import 'Models/ExerciseData.dart';
import 'Models/Routine.dart';
import 'Models/Exercise.dart';
import 'dart:async';

class WorkoutDetail extends StatelessWidget {
  final Workout workout;
  String formatted;
  String formatted1;
  var formatter = new DateFormat('dd/MM/yyyy');
  var formatter1 = new DateFormat('jm');
  WorkoutDetail({@required this.workout}){
    formatted= formatter.format(DateTime.parse(workout.date));
    formatted1 = formatter1.format(DateTime.parse(workout.date));
  }
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
              return new Center(child: Text('This workout has no exercises part of it!'));
            else
              return _exercises(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Delete Workout"),
              onPressed: () {
                db.get().removeWorkout(workout.id);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
            Center(
              child: Text('${workout.name}',
                style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700)
              )
            ),
            Center(
              child: Text(
                'Started $formatted at $formatted1',
                style: const TextStyle(fontSize: 18.0),
              )
            ),
            fut,
          ],
        ),
      )
    );
  }

  _exercises(BuildContext context, AsyncSnapshot snapshot){
    var data = snapshot.data[0];
    var exe = snapshot.data[1];
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: data.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _exercise(data[index], exe[index]);
        }
    );
  }

  _exercise(ExerciseData exd, Exercise ex){
    if(ex.flag == 0) {
      return ListTile(
        title: Text('${ex.name}'),
        subtitle: Text(
            'Weight: ${exd.weight}kg, Reps: ${exd.reps}, Sets: ${exd.sets}'),
      );
    }
    else{
      return ListTile(
        title: Text('${ex.name}'),
        subtitle: Text(
            'Distance: ${exd.distance}km, Time: ${exd.time}mins'),
      );
    }
  }

  data() async{
    var list = [];
    List ed = await db.get().getEDByWorkout('${workout.id}');
    var exe = [];
    ed.forEach((e) async{
      exe.add(await db.get().getExercise('${e.exercise}'));
    });
    await new Future.delayed(Duration(milliseconds: 50));
    list = [ed, exe];
    return list;
  }

}