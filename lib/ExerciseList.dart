import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'newExercise.dart';
import 'ExerciseDetail.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class ExercisesList extends StatefulWidget{
  Database _db;
  ExercisesList({Database db = null}){
    db = _db;
  }
  @override
  ExercisesListState createState() => new ExercisesListState();
}

class ExercisesListState extends State<ExercisesList>{
  List _exerciseArr = [
    {
      'name':'Back Squat',
      'notes': 'Notes'

    },
    {
      'name':'Bench Press',
      'notes': 'Notes'

    },
    {
      'name':'Front Squat',
      'notes': 'Notes'

    },
    {
      'name':'Deadlift',
      'notes': 'Notes'

    },
    {
      'name':'Dumbell Press',
      'notes': 'Notes'

    },
    {
      'name':'5 Mile Run',
      'notes': 'Notes'

    },
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: _exercises(),
        ),
        floatingActionButton: new FloatingActionButton(
          heroTag: "Exercise1",
          onPressed: _addExericse,
          child: Icon(Icons.add),
        )
    );
  }

  Widget _exercises(){
    var _length = _exerciseArr.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _exercise(_exerciseArr[index]);
        }
    );
  }

  Widget _exercise(Map h){
    return ListTile(
      title: Text(
        h['name'],
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {
          print("Hello");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetail(exercise: h),
            ),
          );
        });
      },
    );
  }

  void _addExericse() {
    /// This will use a route to go to a new page. On this page a new routine can
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
      MaterialPageRoute(builder: (context) => newExercise()),
    );

    // After the Selection Screen returns a result, show it in a Snackbar!
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    _exerciseArr.add({
      'name': '${result["name"]}',
      'notes' : '${result["notes"]}'
    });
    /// Here I should add this to the DB or whatever storage this uses
  }
}

/// How to use a snackbar
//    final snackBar = SnackBar(
//      content: Text('Yay! A SnackBar!'),
//      action: SnackBarAction(
//        label: 'Undo',
//        onPressed: () {
//          // Some code to undo the change!
//        },
//      ),
//    );
//    Scaffold.of(context).showSnackBar(snackBar);

