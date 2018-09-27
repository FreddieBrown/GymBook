import "package:flutter/material.dart";

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help")),
      body: Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 4.0),
        child: ListView(
          children: <Widget>[
            Text("Hi there! Looking for help?",
                style: const TextStyle(fontSize: 26.0)),
            Text(
                "\nThis is the help section of the app.\nOn the main page of the "
                "app you will be presented with 3 screens that can be navigated by "
                "using the bar at the bottom of the screen. These 3 screens are: "
                "\n*Workout\n*Routines\n*Exercises\nThese 3 screens are the main "
                "parts of the app. Each is explained in the sections below!"),
            Text("\nExercises", style: const TextStyle(fontSize: 26.0)),
            Text(
                "\nExercises are the building blocks of this process. They are used "
                "to make up a routine. On the Exercises screen you can create your "
                "own and can delete the ones which are already there. To create "
                "a new exercise, tap on the plus button and give it a name, some "
                "notes on how to do the exercise and select cardio if it is a "
                "cardio exercise (as opposed to a weights exercise). Press the "
                "save button to create the exercise. To view an exercise, tap on "
                "its card on the main menu. Here you can read about the exercise "
                "or you can delete it by pressing the delete button."),
            Text("\nRoutines", style: const TextStyle(fontSize: 26.0)),
            Text(
                "\nRoutines are like a list of different exericses that are to be "
                "performed together when working out. A routine contains as many "
                "exercises as you like. Tap on the plus button to create a new "
                "routine and give it a name. Then, when back on the rotuines menu, "
                "tap on the routine to edit it. Here you can delete a routine and "
                "add exercises to it. To add an exercise to a routine, tap on the "
                "plus button in the bottom right corner. Here, tap on the exercise "
                "you want to do and it adds it to your routine. If you want to delete "
                "it, just tap on the bin and it  removes it from your routine! "
                "To save it, press the save button."),
            Text("\nWorkouts", style: const TextStyle(fontSize: 26.0)),
            Text("\nWorkouts are the main part of this application and are the "
                "most used part. Each workout is based on a previously created "
                "routine, or you can create your own one there and then. To create "
                "a workout, tap the plus button in the bottom right hand corner of "
                "the Workouts home screen. Here you will name your workout. Once "
                "this is done, you will move to the next screen where you select "
                "your routine you are using at that point. After this, save it and "
                "you will be returned to the home screen once again. If you tap "
                "on your workout from here you will be able to enter more detail "
                "about your workout. You can specify how many reps, sets and the "
                "weight of a weights exercise and the time and distance of a cardio "
                "exercise. Save each time you do this and then save your workout!\n"),
          ],
        ),
      ),
    );
  }
}
