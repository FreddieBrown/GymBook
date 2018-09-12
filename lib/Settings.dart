import 'package:flutter/material.dart';
import 'database/db.dart';
import 'Models/Exercise.dart';
import 'Help.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth.dart';
import 'Models/User.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Set extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
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
            else if (snapshot.data.length == 0) {
              return Padding(
                  padding: EdgeInsets.only(top: 300.0),
                  child: Center(child: Text("You aren't logged in")));
            } else
              return _data(context, snapshot);
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
        ),
        body: Container(
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30.0, bottom: 30.0, left: 122.0, right: 122.0),
                      child: Text("Help",
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Help()));
                  },
                ),
                GestureDetector(
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30.0, bottom: 30.0, left: 102.0, right: 102.0),
                      child: Text("Reset Data",
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      reset();
                    });
                  },
                ),
                GestureDetector(
                  child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30.0, bottom: 30.0, left: 115.0, right: 115.0),
                      child:
                          Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  onTap: () async {
                    await Auth.logoutUser();
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                fut,
              ],
            )));
  }

  reset() async {
    db data = db.get();
    await db.get().data.delete("Workouts");
    await db.get().data.delete("Routines");
    await db.get().data.delete("Exercises");
    await db.get().data.delete("RoutineExercises");
    await db.get().data.delete("ExerciseData");
    await db.get().data.delete("users");
    await data.init();

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
        name: 'Freddie',
        hashp: passh.toString(),
        email: 'fred@noser.net',
        dev: 1);

    await db.get().updateUser(u);

    exe.forEach((element) async {
      await db.get().updateExercise(element);
    });

    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  _data(BuildContext context, AsyncSnapshot snapshot) {
    List list = snapshot.data;
    return Card(
      color: Colors.blue,
      child: Padding(
        padding:
            EdgeInsets.only(top: 30.0, bottom: 30.0, left: 68.0, right: 68.0),
        child: Text(
            "ID: ${list[0]}\nEmail: ${list[1]}\nName: ${list[2]}\nDev: ${list[3]}",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  data() async {
    final prefs = await SharedPreferences.getInstance();
    var list = [prefs.get('id'), prefs.get('email'), prefs.get('name')];
    if (prefs.get('dev') == 1) {
      list.add("Dev Mode on");
    } else {
      list.add("Dev Mode off");
    }
    return list;
  }
}
