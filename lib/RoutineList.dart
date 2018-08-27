import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'newRoutine.dart';
import 'RoutineDetail.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class RoutineList extends StatefulWidget{
  Database _db;
  RoutineList({Database db = null}){
    db = _db;
  }
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList>{
  List _routineArr = [
    {
      'name':'Routine 1',
      'exercises':11

    },
    {
      'name':'Routine 2',
      'exercises':16

    },
    {
      'name':'Routine 3',
      'exercises':5

    },
    {
      'name':'Routine 4',
      'exercises':6

    },
    {
      'name':'Routine 5',
      'exercises':4

    },
    {
      'name':'Routine 6',
      'exercises':8

    },
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

  Widget _routine(Map h){
    var e = h['exercises'];
    return ListTile(
      title: Text(
        h['name'],
        style: _biggerFont,
      ),
      subtitle: Text(
        "Predicted Time: $e mins",
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          print("Hello");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineDetail(routine: h),
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
    _routineArr.add({
        'name': '$result',
        'exercises':10,
      });
  }

}