import 'package:flutter/material.dart';
import 'newRoutine.dart';
import 'RoutineDetail.dart';
import 'Models/Routine.dart';
import 'Models/RoutineExercise.dart';
import 'database/db.dart';
import 'dart:async';

final _biggerFont = const TextStyle(fontSize: 18.0);

class RoutineList extends StatefulWidget{
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList>{

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
              return Text("You don't have any routines, try creating one!");
            }
            else
              return _routines(context, snapshot);
        }
      },
    );

    return Scaffold(
        body: Center(
          child: fut,
        ),
        floatingActionButton: new FloatingActionButton(
          heroTag: "Routine1",
          onPressed: _addRoutine,
          child: Icon(Icons.add),
        )
    );
  }

  Widget _routines(BuildContext context, AsyncSnapshot snapshot){
    var ra = snapshot.data;
    var _length = ra.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
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
    return ListTile(
      title: Text(
        r.name,
        style: _biggerFont,
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineDetail(r),
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

  Future<List<Routine>> data() async{
    var list;
    try {
      list = await db.get().getRoutines();
    }
    catch(e){
      print(e.toString());
    }
    return list;
  }
}