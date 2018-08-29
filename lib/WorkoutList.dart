import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newWorkout.dart';
import 'WorkoutDetail.dart';
import 'Models/Workout.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class WorkoutList extends StatefulWidget{
  @override
  WorkoutListState createState() => new WorkoutListState();
}
/// This is used to describe the state of the homeList StatefulWidget. It uses
/// _workouts() as its body.
class WorkoutListState extends State<WorkoutList> {
  /// TODO: This is where SQL will be used to get Workout details
  var work = [
    new Workout(id: 1, name: "Workout1", date: new DateTime.now()),
    new Workout(id: 2, name: "Workout2", date: new DateTime.now()),
    new Workout(id: 3, name: "Workout3", date: new DateTime.now()),
    new Workout(id: 4, name: "Workout4", date: new DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _workouts(),
      floatingActionButton: new FloatingActionButton(
        heroTag: "Workout1",
        onPressed: _addWorkout,
        child: Icon(Icons.add),
      ),
    );
  }

  /// This builds a list using _workout() which is shown by homeList
  Widget _workouts() {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: work.length*2,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _workout(work[index]);
        }
    );
  }

  /// Returns a single ListTile Widget
  Widget _workout(Workout workout) {
    var formatter = new DateFormat('dd/MM/yyyy');
    var formatter1 = new DateFormat('jm');
    String formatted = formatter.format(workout.date);
    String formatted1 = formatter1.format(workout.date);
    String text = "${workout.name}";
    String date = "$formatted at $formatted1";
    return ListTile(
      title: Text(
        text,
        style: _biggerFont,
      ),
      subtitle: Text(date),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          print("Hello");

          /// This is an example of how to push data to another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutDetail(name: text, date: date),
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
    print('$result');
    work.add(new Workout(id: work.length+2, name: "$result", date: new DateTime.now()));
  }
}