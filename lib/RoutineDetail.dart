import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Exercise.dart';
import 'ExerciseDetail.dart';
import 'database/db.dart';

class RoutineDetail extends StatelessWidget {
  final Routine routine;
  final List routineEx;

  static List exercises = [
    new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight"),
    new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor"),
    new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest"),
    new Exercise(name: "Running", id: 4, notes: "Just Run"),
  ];

  List exe = exercises;
  RoutineDetail({Key key, @required this.routine, this.routineEx}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Center(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
            '${routine.name}',
            style: const TextStyle(fontSize: 26.0),
          ))),
          new Align(
            alignment: Alignment.center,
            child: _routineD(),
          ),
        ],
      ),
    );
  }


  Widget _routineD(){
    List re = [];
    routineEx.forEach((element) {
      exercises.forEach((exercise) {
        if(element.exercise == exercise.id){
          re.add(element);
        }
      });
    });

    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: re.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _exercise(re[index], context);
        }
    );

  }

  Widget _exercise(RoutineExercise re, context){
    var ex;
    exercises.forEach((exercise) {
      if(re.exercise == exercise.id){
        ex = exercise;
      }
    });
    return ListTile(
      title: Text(ex.name),
      subtitle: re.reps == 0? Text('Distance: ${re.distance}km Time: ${re.time}mins') : Text('Reps: ${re.reps} Sets: ${re.sets} Weight: ${re.weight}kg'),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetail(exercise: ex),
          ),
        );
      }
    );

  }

  data() async{
    List ids;
    routineEx.forEach((element){
      ids.add('${element.exercise}');
    });
     exe = await db.get().getExercises(ids);
     return exe;
  }
}