import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newWorkout.dart';
import 'WorkoutDetail.dart';
import 'Models/Workout.dart';
import 'database/db.dart';
import 'GymButton.dart';
import 'dart:io' show Platform;
import 'GymPageRoute.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class WorkoutList extends StatefulWidget{
  @override
  WorkoutListState createState() => new WorkoutListState();
}
/// This is used to describe the state of the homeList StatefulWidget. It uses
/// _workouts() as its body.
class WorkoutListState extends State<WorkoutList> {

  @override
  void initState() {
    super.initState();
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
              return new Text('Error: ${snapshot.error}');
            else if(snapshot.data.length == 0){
              return Column(
                children: <Widget>[
                  GymButton(func: _addWorkout, text: Text("Add Workout", style: const TextStyle(color: Colors.white))),
                  Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Center(
                          child: Text("You don't have any Workouts, try creating one!")
                      )
                  )
                ],
              );
            }
            else
              return _workouts(context, snapshot);
        }
      },
    );

    return Scaffold(
      body: fut,
    );
  }

  /// This builds a list using _workout() which is shown by homeList
  Widget _workouts(BuildContext context, AsyncSnapshot snapshot) {
    var workouts = snapshot.data;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: workouts.length+2,
        itemBuilder: (context, i) {
          if(i == workouts.length){
            return GymButton(func: _addWorkout, text: Text("Add Workout", style: const TextStyle(color: Colors.white)));
          }
          else if(i == workouts.length+1){
            if(Platform.isAndroid) {
              return Container(
                padding: EdgeInsets.all(50.0),
              );
            }
            else{
              return Container(
                padding: EdgeInsets.all(60.0),
              );
            }
          }
          return _workout(workouts[workouts.length-i-1]);
        }
    );
  }

  /// Returns a single ListTile Widget
  Widget _workout(Workout workout) {
    var formatter = new DateFormat('dd/MM/yyyy');
    var formatter1 = new DateFormat('jm');
    String formatted = formatter.format(DateTime.parse(workout.date));
    String formatted1 = formatter1.format(DateTime.parse(workout.date));
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          title: Text(
            "${workout.name}",
            style: _biggerFont,
          ),
          subtitle: Text("$formatted at $formatted1"),
          trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {
            setState(() {
              /// This is an example of how to push data to another screen
              Navigator.push(
                context,
                GymPageRoute(
                  builder: (context) => WorkoutDetail(workout: workout),
                ),
              );
            });
          },
        )
    );
  }

  void _addWorkout() {
    /// This will use a route to go to a new page. On this page a new workout can
    /// be created.
    setState(() {
      _navigateAndDisplaySelection(context);
    });
  }

  /// This will push a new page onto the stack and will wait to receive data back.
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newWorkout()),
    );

    // After the Selection Screen returns a result, show it in a Snackbar!
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
//    work.add(new Workout(id: work.length+2, name: "$result", date: '${DateTime.now()}'));
    if('$result' != 'null') {
      try {
        db.get().updateWorkout(
            Workout(name: result, routine: 1, date: '${DateTime.now()}'));
      }
      catch(e){
        print(e.toString());
      }
    }
  }

   data() async{
    var list;
    try {
      list = await db.get().getWorkouts();
    }
    catch(e){
      print(e.toString());
    }
    return list;
  }
}