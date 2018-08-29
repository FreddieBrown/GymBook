import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';
import 'Home.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);
void main(){
  runApp(new GymBook());
}

class GymBook extends StatelessWidget {
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
        child: Home(),
      ),
    );
  }
}
