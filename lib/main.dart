import 'package:flutter/material.dart';
import 'Home.dart';
import 'database/db.dart';
import 'Models/Exercise.dart';
import 'Login.dart';
import 'Models/User.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'Register.dart';
import 'Auth.dart';
import 'UserEnter.dart';

void main() async {
  List exe = [
    new Exercise(
        name: "Bench Press",
        id: 1,
        notes:
            "Hold bar above chest and bring down until arms are at right angles before pushing bar back up until arms are straight",
        flag: 0),
    new Exercise(
        name: "Squat",
        id: 2,
        notes:
            "Crouch down keeping back straight until knees and thigh are at a right angle with the floor",
        flag: 0),
    new Exercise(
        name: "Barbell Curl", id: 3, notes: "Bring bar up to chest", flag: 0),
    new Exercise(name: "Running", id: 4, notes: "Just Run", flag: 1),
    new Exercise(name: "Rowing", id: 5, notes: "Just Row", flag: 1),
    new Exercise(
        name: "Bent over rows",
        id: 6,
        notes:
            "Hold bar with arms straight and bend over and knees slightly flexed. Pull up bar to chest only moving arms and the bar.",
        flag: 0),
    new Exercise(
        name: "Overhead Press",
        id: 7,
        notes:
            "Hold bar on chest and push up until arms straight. When arms are straight up above your head with with bar, bring back down to chest and repeat.",
        flag: 0),
    new Exercise(name: "Walking", id: 8, notes: "Just Walk!", flag: 1),
  ];
  var salt = '${DateTime.now()}';
  var pass = 'password';
  var utfSalt = utf8.encode(salt);
  var salth = sha256.convert(utfSalt);
  var utfPass = utf8.encode("$pass+${salth.toString()}");
  var passh = sha256.convert(utfPass);

  User u = User(
      id: 1,
      salt: salth.toString(),
      name: 'Admin',
      hashp: passh.toString(),
      email: 'freddieabrown@gmail.com',
      dev: 1);

  db data = db.get();

  reset() async {
    db.get().data.delete("Workouts");
    db.get().data.delete("Routines");
    db.get().data.delete("Exercises");
    db.get().data.delete("RoutineExercises");
    db.get().data.delete("ExerciseData");
    db.get().data.delete("users");
    await data.init();
  }

  try {
    await data.init();
    await db.get().updateUser(u);
  } catch (e) {
    print(e.toString());
  }

  exe.forEach((element) async {
    await db.get().updateExercise(element);
  });

  var stat = await db.get().getStatus();
  if (stat == null) {
    runApp(new GymBook1());
  } else {
    var u = await db.get().getUser('${stat.id}');
    runApp(new GymBook2(u));
  }
}

class GymBook1 extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (context) => Home(),
          '/user': (context) => UserEnter(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Gym Book',
        theme: new ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          textTheme: TextTheme(
              display1: TextStyle(color: Colors.white),
              display2: TextStyle(color: Colors.white),
              display3: TextStyle(color: Colors.white),
              display4: TextStyle(color: Colors.white),
              headline: TextStyle(color: Colors.white),
              subhead: TextStyle(color: Colors.white),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
              button: TextStyle(color: Colors.white),
              title: TextStyle(color: Colors.white),
              caption: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: Colors.grey[800],
          cardColor: Colors.grey[900],
          iconTheme: IconThemeData(color: Colors.white),
          accentIconTheme: IconThemeData(color: Colors.white),
          fontFamily: 'Nunito',
        ),
        home: UserEnter()
//      home: Home()
        );
  }
}

class GymBook2 extends StatelessWidget {
  // This widget is the root of the application.
  User u;
  GymBook2(this.u) {
    Auth.setUp(u);
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (context) => Home(),
          '/user': (context) => UserEnter(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Gym Book',
        theme: new ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          textTheme: TextTheme(
              display1: TextStyle(color: Colors.white),
              display2: TextStyle(color: Colors.white),
              display3: TextStyle(color: Colors.white),
              display4: TextStyle(color: Colors.white),
              headline: TextStyle(color: Colors.white),
              subhead: TextStyle(color: Colors.white),
              body1: TextStyle(color: Colors.white),
              body2: TextStyle(color: Colors.white),
              button: TextStyle(color: Colors.white),
              title: TextStyle(color: Colors.white),
              caption: TextStyle(color: Colors.white)),
          scaffoldBackgroundColor: Colors.grey[800],
          cardColor: Colors.grey[900],
          iconTheme: IconThemeData(color: Colors.white),
          accentIconTheme: IconThemeData(color: Colors.white),
          fontFamily: 'Nunito',
        ),
        home: Home()
        );
  }
}
