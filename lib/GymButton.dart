import 'package:flutter/material.dart';

class GymButton extends StatelessWidget{
  Function func;
  MaterialColor colour;
  Widget text;

  GymButton({this.colour = Colors.blue, this.func, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        color: colour,
        child: Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 120.0, right: 120.0),
          child: text,
        ),
      ),
      onTap: func,
    );
  }
}