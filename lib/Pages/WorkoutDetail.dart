import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/Workout.dart';
import '../database/db.dart';
import '../Models/ExerciseData.dart';
import '../Models/Exercise.dart';
import 'dart:async';
import 'package:gym_book/Pages/ExerciseDataSelector.dart';
import '../Utilities/GymPageRoute.dart';
import '../Utilities/GymButton.dart';

class WorkoutDetail extends StatefulWidget {
  Workout workout;
  WorkoutDetail({@required this.workout});
  @override
  WorkoutDetailState createState() => WorkoutDetailState(this.workout);
}

class WorkoutDetailState extends State<WorkoutDetail> {
  final Workout workout;
  String formatted;
  String formatted1;
  bool b;
  var formatter = new DateFormat('dd/MM/yyyy');
  var formatter1 = new DateFormat('jm');
  WorkoutDetailState(this.workout) {
    formatted = formatter.format(DateTime.parse(workout.date));
    formatted1 = formatter1.format(DateTime.parse(workout.date));
    if (workout.status == 0) {
      b = false;
    } else {
      b = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fut = FutureBuilder(
      future: data(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              return new Center(
                  child: Text('This workout has no exercises part of it!'));
            else
              return _exercises(context, snapshot);
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Workout"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Center(
                  child: Text('${workout.name}',
                      style: const TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w700))),
              Center(
                  child: Text(
                'Started $formatted at $formatted1',
                style: const TextStyle(fontSize: 18.0),
              )),
              fut,
              SwitchListTile(
                  title: Text("Workout done?"),
                  value: b,
                  onChanged: (bool v) async {
                    if (b == false) {
                      workout.status = 1;
                      await db.get().updateWorkout(workout);
                    } else {
                      workout.status = 0;
                      await db.get().updateWorkout(workout);
                    }
                    setState(() {
                      b = v;
                    });
                  }),
              GymButton(
                  func: () {
                    db.get().removeWorkout(workout.id);
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  text: Text("Delete Workout",
                      style: const TextStyle(color: Colors.white))),
            ],
          ),
        ));
  }

  _exercises(BuildContext context, AsyncSnapshot snapshot) {
    var data = snapshot.data[0];
    var exe = snapshot.data[1];
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, i) {
          return _exercise(data[i], exe[i], context);
        });
  }

  _exercise(ExerciseData exd, Exercise ex, BuildContext context) {
    if (ex.flag == 0) {
      return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: ListTile(
            title: Text('${ex.name}'),
            subtitle: Text(
                'Reps: ${exd.reps}, Sets: ${exd.sets}, Weight: ${exd.weight}kg '),
            trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                GymPageRoute(
                  builder: (context) => ExerciseDataSelector(exd, ex, workout),
                ),
              );
            },
          ));
    } else {
      return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: ListTile(
            title: Text('${ex.name}'),
            subtitle:
                Text('Distance: ${exd.distance}km, Time: ${exd.time}mins'),
            trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                GymPageRoute(
                  builder: (context) => ExerciseDataSelector(exd, ex, workout),
                ),
              );
            },
          ));
    }
  }

  data() async {
    var list = [];
    List ed = await db.get().getEDByWorkout('${workout.id}');
    var exe = [];
    ed.forEach((e) async {
      exe.add(await db.get().getExercise('${e.exercise}'));
    });
    await new Future.delayed(Duration(milliseconds: 50));
    list = [ed, exe];
    return list;
  }
}
