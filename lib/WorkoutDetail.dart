import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class WorkoutDetail extends StatelessWidget {
  final String name;
  final String date;
  WorkoutDetail({Key key, @required this.name, @required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text('$name',
              style: const TextStyle(fontSize: 18.0)
              ),
            Text(
              '$date',
              style: const TextStyle(fontSize: 11.0),
            ),
          ],
        ),
      ),
    );
  }
}