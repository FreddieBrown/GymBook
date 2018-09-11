import 'package:flutter/material.dart';
import 'GymButton.dart';
import 'Auth.dart';

class Login extends StatefulWidget{
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.blue[300],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
              child: Text('GymBook', style: TextStyle(color: Colors.white, fontSize: 60.0)),
            ),
            GymButton(func: (){Navigator.pushNamed(context, '/home');}, text: Text('Login'),),
          ],
        ),
      ),
    );
  }
}

