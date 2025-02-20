import 'package:flutter/material.dart';
import '../Models/Exercise.dart';
import '../database/db.dart';
import '../Models/RoutineExercise.dart';

class ExerciseSelector extends StatefulWidget {
  var routine;
  ExerciseSelector(this.routine);
  @override
  ExerciseSelectorState createState() => ExerciseSelectorState(routine);
}

class ExerciseSelectorState extends State<ExerciseSelector> {
  final routine;
  ExerciseSelectorState(this.routine);
  @override
  Widget build(BuildContext context) {
    var fut = FutureBuilder(
      future: data(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            else
              return exercises(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Select an Exercise"),
        centerTitle: true,
      ),
      body: fut,
    );
  }

  ///Build a list of all Exercises in the database
  /// Allow a user to select one of them
  /// Pass that exercise back to the RoutineBuilder with a list which includes
  /// the new exercise.

  Widget exercises(BuildContext context, AsyncSnapshot snapshot) {
    var exe = snapshot.data;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: exe.length,
        itemBuilder: (context, i) {
          return exercise(exe[i]);
        });
  }

  Widget exercise(Exercise e) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          title: Text('${e.name}'),
          trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {
            var r =
                RoutineExercise(id: null, exercise: e.id, routine: routine.id);
            db.get().updateRoutineExercise(r);
            setState(() {
              Navigator.pop(context);
            });
          },
        ));
  }

  data() async {
    var exe;
    try {
      exe = await db.get().getExercises();
    } catch (e) {
      print(e.toString());
    }
    return exe;
  }
}
