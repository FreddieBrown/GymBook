import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database/database.dart';
import 'package:sqflite/sqflite.dart';
class RoutineDetail extends StatelessWidget {
  final Map routine;

  RoutineDetail({Key key, @required this.routine}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Routine"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Text(
            '${routine['name']}',
            style: const TextStyle(fontSize: 26.0),
          ),
          Text(
            '${routine['exercises']} mins',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}