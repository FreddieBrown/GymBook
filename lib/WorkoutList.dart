import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newWorkout.dart';
import 'WorkoutDetail.dart';
import 'Models/Workout.dart';
import 'database/db.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class WorkoutList extends StatefulWidget{
  @override
  WorkoutListState createState() => new WorkoutListState();
}
/// This is used to describe the state of the homeList StatefulWidget. It uses
/// _workouts() as its body.
class WorkoutListState extends State<WorkoutList> {
  /// Need to work out how to get workout information from the start and not after 1 refresh
  /// TODO: This is where SQL will be used to get Workout details

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
            return new Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return _workouts(context, snapshot);
        }
      },
    );

    return Scaffold(
      body: fut,
      floatingActionButton: new FloatingActionButton(
        heroTag: "Workout1",
        onPressed: _addWorkout,
        child: Icon(Icons.add),
      ),
    );
  }

  /// This builds a list using _workout() which is shown by homeList
  Widget _workouts(BuildContext context, AsyncSnapshot snapshot) {
    var workouts = snapshot.data;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: workouts.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _workout(workouts[index]);
        }
    );
  }

  /// Returns a single ListTile Widget
  Widget _workout(Workout workout) {
    var formatter = new DateFormat('dd/MM/yyyy');
    var formatter1 = new DateFormat('jm');
    String formatted = formatter.format(DateTime.parse(workout.date));
    String formatted1 = formatter1.format(DateTime.parse(workout.date));
    return ListTile(
      title: Text(
        "${workout.name}",
        style: _biggerFont,
      ),
      subtitle: Text("$formatted at $formatted1"),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          /// This is an example of how to push data to another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutDetail(workout: workout),
            ),
          );
        });
      },
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