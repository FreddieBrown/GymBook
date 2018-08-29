import 'package:flutter/material.dart';

class Set extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget{
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Text("Settings"),
    );
  }
}