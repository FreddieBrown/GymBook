import 'package:flutter/material.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';

class Home extends StatelessWidget{
  final _work = Runes(' \u{1F3CB} ');
  final _work1 = Runes('\u{1F501}');
  final _work2 = Runes('\u{1F938}');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomSheet: Card(
            margin: EdgeInsets.all(0.0),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TabBar(
                  labelColor: Colors.blue[200],
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(child: Text("Workouts", style: const TextStyle(fontSize: 17.0))),
                    Tab(child: Text("Routines" , style: const TextStyle(fontSize: 18.0))),
                    Tab(child: Text("Exercises" , style: const TextStyle(fontSize: 18.0))),
                  ],
                )
            ),
      ),
      appBar: AppBar(
//        bottom: TabBar(
//          tabs: [
//            Tab(text: "Workouts "+String.fromCharCodes(_work)),
//            Tab(text: "Routines "+String.fromCharCodes(_work1)),
//            Tab(text: "Exercises "+String.fromCharCodes(_work2)),
//          ],
//        ),
        title: Text('GymBook'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: Icon(Icons.list),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              }
          ),
        ],
        centerTitle: true,
      ),
      body: TabBarView(
        children: [
          WorkoutList(),
          RoutineList(),
          ExercisesList(),
        ],
      ),
    );
  }
}