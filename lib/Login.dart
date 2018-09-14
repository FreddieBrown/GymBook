import 'package:flutter/material.dart';
import 'GymButton.dart';
import 'Auth.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  Text error = Text('');
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.grey[800],
        child: Padding(
          padding: EdgeInsets.only(right: 18.0, left: 18.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 80.0, bottom: 40.0, left: 10.0, right: 10.0),
                  child: Center(
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 40.0)),
                  )
              ),
              TextField(
                controller: email,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(),
                    hintText: "Email"),
              ),
              TextField(
                controller: password,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(),
                    hintText: "Password"),
              ),
              Center(child: widget.error),
              GymButton(
                func: () async {
                  if (email.text.isEmpty) {
                    setState(() {
                      widget.error = Text("You have to enter an email",
                          style: TextStyle(color: Colors.red, fontSize: 22.0));
                    });
                  } else if (!(await Auth.isUser(email.text.toLowerCase()))) {
                    setState(() {
                      widget.error = Text(
                          "There is an error with your email or password",
                          style: TextStyle(color: Colors.red, fontSize: 22.0));
                    });
                  } else {
                    if (password.text.length < 8) {
                      setState(() {
                        widget.error = Text(
                            "There is an error with your email or password",
                            style: TextStyle(color: Colors.red, fontSize: 22.0));
                      });
                    } else if ((await Auth.checkUser(
                        email.text, password.text)) ==
                        null) {
                      setState(() {
                        widget.error = Text(
                            "There is an error with your email or password",
                            style: TextStyle(color: Colors.red, fontSize: 22.0));
                      });
                    } else {
                      Auth.loginUser(email.text, password.text);
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                },
                text: Center(
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
