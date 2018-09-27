import 'package:flutter/material.dart';
import 'package:gym_book/Pages/newRoutine.dart';
import 'package:gym_book/Pages/RoutineDetail.dart';
import '../Models/Routine.dart';
import '../database/db.dart';
import 'dart:async';
import '../Utilities/GymButton.dart';
import 'dart:io' show Platform;
import '../Utilities/GymPageRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _biggerFont = const TextStyle(fontSize: 18.0);

class RoutineList extends StatefulWidget {
  @override
  RoutineListState createState() => new RoutineListState();
}

class RoutineListState extends State<RoutineList> {
  @override
  void initState() {
    super.initState();
  }

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
              return Column(
                children: <Widget>[
                  GymButton(
                      func: _addRoutine,
                      text: Text("Add Routine",
                          style: const TextStyle(color: Colors.white))),
                  Padding(
                      padding: EdgeInsets.only(top: 300.0),
                      child: Center(
                          child: Text(
                              "You don't have any Routines, try creating one!")))
                ],
              );
            } else
              return _routines(context, snapshot);
        }
      },
    );

    return Scaffold(
      body: Center(
        child: fut,
      ),
    );
  }

  Widget _routines(BuildContext context, AsyncSnapshot snapshot) {
    var ra = snapshot.data;
    var _length = ra.length;
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _length + 2,
        itemBuilder: (context, i) {
          if (i == _length) {
            return GymButton(
                func: _addRoutine,
                text: Text("Add Routine",
                    style: const TextStyle(color: Colors.white)));
          } else if (i == _length + 1) {
            if (Platform.isAndroid) {
              return Container(
                padding: EdgeInsets.all(50.0),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(60.0),
              );
            }
          }
          return _routine(ra[i]);
        });
  }

  Widget _routine(Routine r) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ListTile(
          title: Text(
            r.name,
            style: _biggerFont,
          ),
          trailing: new Icon(Icons.keyboard_arrow_right, color: Colors.blue),
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                GymPageRoute(
                  builder: (context) => RoutineDetail(r),
                ),
              );
            });
          },
        ));
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
    var id = await getID();
    final result = await Navigator.push(
      context,
      GymPageRoute(builder: (context) => newRoutine(id)),
    );
    if ('$result' != 'null') {
      db.get().updateRoutine(Routine(name: result, user: id));
    }
  }

  Future<List<Routine>> data() async {
    List list;
    var id = await getID();
    try {
      list = await db.get().getRoutinesByUser(['$id']);
    } catch (e) {
      print(e.toString());
    }
    return list;
  }

  getID() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');
    return id;
  }
}
