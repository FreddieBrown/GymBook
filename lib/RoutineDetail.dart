import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Exercise.dart';
import 'ExerciseDetail.dart';
import 'database/db.dart';
import 'ExerciseSelector.dart';
import 'dart:async';

final _biggerFont = const TextStyle(fontSize: 18.0);
class RoutineDetail extends StatefulWidget{
  var routine;
  RoutineDetail(this.routine);
  @override
  RoutineDetailState createState() => RoutineDetailState(routine: routine);
}

class RoutineDetailState extends State<RoutineDetail> {
  final Routine routine;
  var exercises;

  RoutineDetailState({@required this.routine});

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
              return new Center(child: Text('Add some Exercises to this Routine!', style: _biggerFont,));
            else
              return _routineD(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          RaisedButton(
              child: Text("Delete Routine"),
              onPressed: () {
                db.get().removeRoutine(routine.id);
                Navigator.pop(context);
              },
          ),
          Center(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
            '${routine.name}',
                  style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)
          ))),
          new Align(
            alignment: Alignment.center,
            child: fut,
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            _navigateAndDisplaySelection(context);
        },
      ),
    );
  }


  Widget _routineD(BuildContext context, AsyncSnapshot snapshot){
    var re = snapshot.data[0];
    exercises = snapshot.data[1];
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: re.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _exercise(re[index], exercises[index], context);
        }
    );

  }

  Widget _exercise(RoutineExercise re, Exercise ex, BuildContext context){
    return ListTile(
      title: Text(ex.name),
      trailing: new Icon(Icons.delete),
      onTap: () {
        db.get().removeRoutineExercise(re.id);
        setState(() {});
      }
    );

  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExerciseSelector(routine)),
    );

  }

  data() async{
    var list = [];
    var list1 = await db.get().getREByRoutine('${routine.id}');
    list.add(list1);
    var list2 = [];
    list1.forEach((re) async{
      var a = await db.get().getExercise('${re.exercise}');
      list2.add(a);
    });
    list.add(list2);
    await new Future.delayed(Duration(milliseconds: 400));
    return list;
  }
}