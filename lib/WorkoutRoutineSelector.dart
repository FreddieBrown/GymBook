import 'package:flutter/material.dart';
import 'Models/Routine.dart';
import 'database/db.dart';
import 'dart:async';
import 'Models/Workout.dart';
import 'ExerciseDataSelector.dart';

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
    return ListTile(
      title: Text(
        r.name,
        style: _biggerFont,
      ),
      subtitle: Text(
        "ID: ${r.id}",
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
          if('$name' != 'null') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExerciseDataSelector(r, name)),
            );
          }

      },
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
}