import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ExerciseSelector.dart';
import 'Models/Exercise.dart';
import 'database/db.dart';
import 'Models/RoutineExercise.dart';
import 'Models/Routine.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);
class RoutineBuilder extends StatefulWidget {
  Routine routine;
  RoutineBuilder(this.routine);
  @override
  RoutineBuilderState createState() => RoutineBuilderState(routine);
}

class RoutineBuilderState extends State<RoutineBuilder> {
  final Routine routine;
  RoutineBuilderState(this.routine);

  @override
  void initState() {
    super.initState();
  }

  /// This is where the exercise selector page will be called from
  // Insert the "next item" into the list model.
  void _insert() async{
  var result;
    setState(() {
      result = Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => ExerciseSelector(),
        ),
      );
    });
    await add(result);
  }

  // Remove the selected item from the list.
  void _remove() {
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {

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
              return exercises(context, snapshot);
        }
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('${routine.name}'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: null,
          ),
      );
  }

  add(result) async{
    var routineE = RoutineExercise(id: null, exercise: result.id, routine: routine.id);
    await db.get().updateRoutineExercise(result);
  }

  Widget exercises(BuildContext context, AsyncSnapshot snapshot) {
    var ex = snapshot.data;
    var _length = ex.length*2;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length,
        itemBuilder: (context, i) {
          if(i.isOdd){
            return new Divider();
          }
          final index = i ~/ 2;
          return exercise(ex[index]);
        }
    );
  }

  Widget exercise(Exercise ex) {
    return ListTile(
      title: Text(
        ex.name,
        style: _biggerFont,
      ),
      trailing: new Icon(Icons.keyboard_arrow_right),
      onTap: _remove,
    );

  }

  data() async{

  }

}


