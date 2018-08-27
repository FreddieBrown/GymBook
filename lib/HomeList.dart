import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'newWorkout.dart';
import 'workoutDetail.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class HomeList extends StatefulWidget{
  Database _db;
  HomeList({Database db = null}){
    db = _db;
  }

  @override
  HomeListState createState() => new HomeListState();
}
/// This is used to describe the state of the homeList StatefulWidget. It uses
/// _workouts() as its body.
class HomeListState extends State<HomeList> {
  var _num = 10;
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
        itemCount: _num,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          return _workout();
        }
    );
  }

  /// Returns a single ListTile Widget
  Widget _workout() {
    var time = DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    var formatter1 = new DateFormat('jm');
    String formatted = formatter.format(time);
    String formatted1 = formatter1.format(time);
    String text = "$formatted at $formatted1";
    return ListTile(
      title: Text(
        text,
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {
          print("Hello");

          /// This is an example of how to push data to another screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => workoutDetail(name: text),
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
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    _num+=2;
  }
}