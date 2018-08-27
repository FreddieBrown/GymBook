import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'package:sqflite/sqflite.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);
void main(){
//  DatabaseClient db = DatabaseClient();
//  db.create();
  runApp(new GymBook());
}

class GymBook extends StatelessWidget {
  final _work = Runes(' \u{1F3CB} ');
  final _work1 = Runes('\u{1F501}');
  final _work2 = Runes('\u{1F938}');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Book',
      theme: new ThemeData(
//        primarySwatch: Colors.white,// Add the 3 lines from here...
        primaryColor: Colors.white,
        accentColor: Colors.blueGrey,
//        dividerColor: Colors.red,
      ),
//      home: new MyHomePage(title: 'GymBook'),
//        home: new homeList(),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Workouts "+String.fromCharCodes(_work)),
                Tab(text: "Routines "+String.fromCharCodes(_work1)),
                Tab(text: "Exercises "+String.fromCharCodes(_work2)),
              ],
            ),
            title: Text('GymBook'),
            actions: <Widget>[      // Add 3 lines from here...
              new IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: null
              ),
            ],
          ),
          body: TabBarView(
            children: [
              WorkoutList(),
              RoutineList(),
              ExercisesList(),
            ],
          ),
        ),
      ),
    );
  }
}