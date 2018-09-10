import 'package:flutter/material.dart';
import 'WorkoutList.dart';
import 'RoutineList.dart';
import 'ExerciseList.dart';
import 'Settings.dart';
import 'GymPageRoute.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      bottomNavigationBar: SafeArea(child: Card(
            margin: EdgeInsets.all(0.0),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(child: Text("Workouts", style: const TextStyle(fontSize: 17.0))),
                    Tab(child: Text("Routines" , style: const TextStyle(fontSize: 18.0))),
                    Tab(child: Text("Exercises" , style: const TextStyle(fontSize: 18.0))),
                  ],
                )
            )
        ),
      ),
      appBar: AppBar(
        title: Text('GymBook'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: Icon(Icons.list),
              onPressed: (){
                Navigator.push(
                  context,
                  GymPageRoute(builder: (context) => Settings()),
                );
              }, color: Colors.white
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