import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'newRoutine.dart';
import 'RoutineDetail.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'database/db.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class RoutineList extends StatefulWidget{
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList>{
  /// Use SQL to get Routines
  static List ra = [
    new Routine(name: "Routine1", id: 1),
    new Routine(name: "Routine2", id: 2)
  ];

  ///Use SQL to get the correct RoutineExercises
  static List rea = [
      new RoutineExercise(routine: 1, exercise: 1, reps: 5, sets: 5, weight: 80.0),
      new RoutineExercise(routine: 1, exercise: 4, time: 12.0, distance: 5.0),
      new RoutineExercise(routine: 2, exercise: 2, reps: 5, sets: 5, weight: 130.0),
      new RoutineExercise(routine: 2, exercise: 3, reps: 8, sets: 3, weight: 30.5),
      new RoutineExercise(routine: 2, exercise: 4, time: 18.0, distance: 6.0)
  ];

  @override
  Widget build(BuildContext context){
    data();
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
    var _length = ra.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return _routine(ra[index]);
        }
    );
  }

  Widget _routine(Routine r){
    var re = [];
    rea.forEach((element) {
      if(element.routine == r.id){
        re.add(element);
      }
    });
    print('${r.name} and ${r.id}');
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
//    ra.add(
//      new Routine(name: result));
    if('$result' != 'null') {
      db.get().updateRoutine(Routine(name: result));
    }
  }

  data() async{
    try {
      ra.forEach((element) {
        db.get().updateRoutine(element);
      });
      ra = await db.get().getRoutines();
    }
    catch(e){
      print(e.toString());
    }
    finally {
      return ra;
    }
  }

  reData() async{
    try {
      rea.forEach((element) {
        db.get().updateRoutineExercise(element);
      });
      rea = await db.get().getRoutineExercises();
    }
    catch(e){
      print(e.toString());
    }
    finally {
      return rea;
    }
  }
}