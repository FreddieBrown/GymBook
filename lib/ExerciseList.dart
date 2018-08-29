import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newExercise.dart';
import 'ExerciseDetail.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class ExercisesList extends StatefulWidget{
  @override
  ExercisesListState createState() => new ExercisesListState();
}

class ExercisesListState extends State<ExercisesList>{
  /// Need to make changes so that Exercises are pulled straight from the DB and not only after
  /// newExercise is pressed.
  static List exe= [
    new Exercise(name: "Bench Press", id: 1, notes: "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight"),
    new Exercise(name: "Squat", id: 2, notes: "Crouch down keeping back straight until knees and thigh are at a right angle with the floor"),
    new Exercise(name: "Barbell Curl", id: 3, notes: "Bring bar up to chest"),
    new Exercise(name: "Running", id: 4, notes: "Just Run"),
  ];
  @override
  Widget build(BuildContext context){
    data();
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
    var _length = exe.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _exercise(exe[index]);
        }
    );
  }

  Widget _exercise(Exercise e){
    return ListTile(
      title: Text(
        e.name,
        style: _biggerFont,
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetail(exercise: e),
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
//    _exerciseArr.add(
//    new Exercise(name: result["name"], id: _exerciseArr.length+2, notes: result["notes"]));
    db.get().updateExercise(new Exercise(name: result["name"], notes: result["notes"]));
    /// Here I should add this to the DB or whatever storage this uses
  }

  data() async{
    exe.forEach((element){
      db.get().updateExercise(element);
    });
    exe = await db.get().getExercises();
    return exe;
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

