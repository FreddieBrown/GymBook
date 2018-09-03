import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Workout.dart';
import 'database/db.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text('${workout.name}',
              style: const TextStyle(fontSize: 18.0)
              ),
            Text(
              '$formatted at $formatted1\n${workout.routine}',
              style: const TextStyle(fontSize: 11.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: (){
            db.get().removeWorkout(workout.id);
            Navigator.pop(context);
          },
      )
    );
  }
}