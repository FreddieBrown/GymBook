import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Exercise.dart';
import 'ExerciseDetail.dart';
import 'database/db.dart';

class RoutineDetail extends StatelessWidget {
  final Routine routine;
  var exercises;

  RoutineDetail({Key key, @required this.routine}) : super(key: key);

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
            return new Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
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
          Center(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
            '${routine.name}',
            style: const TextStyle(fontSize: 26.0),
          ))),
          new Align(
            alignment: Alignment.center,
            child: fut,
          ),
        ],
      ),
    );
  }


  Widget _routineD(BuildContext context, AsyncSnapshot snapshot){
    /// There is a problem with the length bit here
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
    var list = [];
    var list1 = await db.get().getREByRoutine('${routine.id}');
    list.add(list1);
    var list2 = [];
    list1.forEach((re) async{
      var a = await db.get().getExercise('${re.exercise}');
      list2.add(a);
    });
    list.add(list2);
    return list;
  }
}