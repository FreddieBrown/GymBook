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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){

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
              return _exercises(context, snapshot);
        }
      },
    );

    return Scaffold(
        body: Center(
          child: fut,
        ),
        floatingActionButton: new FloatingActionButton(
          heroTag: "Exercise1",
          onPressed: _addExericse,
          child: Icon(Icons.add),
        )
    );
  }

  Widget _exercises(BuildContext context, AsyncSnapshot snapshot){
    var exe = snapshot.data;
    var _length = exe.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
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
    var list;
    try {
      list = await db.get().getExercises();
    }
    catch(e){
      print(e.toString());
    }
    return list;
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

