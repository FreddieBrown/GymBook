import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newRoutine.dart';
import 'RoutineDetail.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class RoutineList extends StatefulWidget{
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList>{
  /// Use SQL to get Routines
  List _routineArr = [
    new Routine(name: "Routine1", id: 1),
    new Routine(name: "Routine2", id: 2)
  ];

  ///Use SQL to get the correct RoutineExercises
  List _REArr = [
      new RoutineExercise(id: 1, routine: 1, exercise: 1, reps: 5, sets: 5, weight: 80.0),
      new RoutineExercise(id: 2, routine: 1, exercise: 4, time: 12.0, distance: 5.0),
      new RoutineExercise(id: 3, routine: 2, exercise: 2, reps: 5, sets: 5, weight: 130.0),
      new RoutineExercise(id: 4, routine: 2, exercise: 3, reps: 8, sets: 3, weight: 30.5),
      new RoutineExercise(id: 5, routine: 2, exercise: 4, time: 18.0, distance: 6.0)
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: _routines(),
        ),
        floatingActionButton: new FloatingActionButton(
          heroTag: "Routine1",
          onPressed: _addRoutine,
          child: Icon(Icons.add),
        )
    );
  }

  Widget _routines(){
    var _length = _routineArr.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _routine(_routineArr[index]);
        }
    );
  }

  Widget _routine(Routine r){
    var re = [];
    _REArr.forEach((element) {
      if(element.routine == r.id){
        re.add(element);
      }
    });
    return ListTile(
      title: Text(
        r.name,
        style: _biggerFont,
      ),
      subtitle: Text(
        "ID: ${r.id}",
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          print("Hello");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineDetail(routine: r, routineEx: re),
            ),
          );
        });
      },
    );
  }

  void _addRoutine() {
    /// This will use a route to go to a new page. On this page a new routine can
    /// be created.
    /// print("Hello");
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
      MaterialPageRoute(builder: (context) => newRoutine()),
    );

    // After the Selection Screen returns a result, show it in a Snackbar!
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    _routineArr.add(
      new Routine(name: result, id: _routineArr.length+2));
  }

}