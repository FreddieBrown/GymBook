import 'package:flutter/material.dart';
import 'newExercise.dart';
import 'ExerciseDetail.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';
import 'GymButton.dart';
import 'dart:io' show Platform;

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
                  GymButton(func: _addExericse, text: Text("Add Exercise", style: const TextStyle(color: Colors.white))),
                  Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Center(
                          child: Text("You don't have any Exercises, try creating one!")
                      )
                  )
                ],
              );

            }
            else
              return _exercises(context, snapshot);
        }
      },
    );

    return Scaffold(
        body: Center(
          child: fut,
        ),
    );
  }

  Widget _exercises(BuildContext context, AsyncSnapshot snapshot){
    var exe = snapshot.data;
    var _length = exe.length;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length+2,
        itemBuilder: (context, i) {
          if(i == _length){
            return GymButton(func: _addExericse, text: Text("Add Exercise", style: const TextStyle(color: Colors.white)));
          }
          else if(i == _length+1){
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
          return _exercise(exe[i]);
        }
    );
  }

  Widget _exercise(Exercise e){
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          title: Text(
            e.name,
            style: _biggerFont,
          ),
          subtitle: Text(
            e.notes,
            maxLines: 1,
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
        )
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
    print(result["flag"]);
    // After the Selection Screen returns a result, show it in a Snackbar!
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
//    _exerciseArr.add(
//    new Exercise(name: result["name"], id: _exerciseArr.length+2, notes: result["notes"]));
    db.get().updateExercise(new Exercise(name: result["name"], notes: result["notes"], flag: result["flag"]));
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

