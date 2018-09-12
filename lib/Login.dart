import 'package:flutter/material.dart';
import 'GymButton.dart';
import 'Auth.dart';

class Login extends StatefulWidget {
  Text emailError = Text('');
  Text passError = Text('');
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
        color: Colors.grey[700],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
              child: Text('GymBook',
                  style: TextStyle(color: Colors.white, fontSize: 60.0)),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                "Email",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
              ),
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
            widget.emailError,
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                "Password",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w700, height: 2.0),
              ),
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
            widget.passError,
            GymButton(
              func: () async {
                if (email.text.isEmpty) {
                  setState(() {
                    widget.emailError = Text("You have to enter an email",
                        style: TextStyle(color: Colors.red));
                  });
                } else if (!(await Auth.isUser(email.text.toLowerCase()))) {
                  setState(() {
                    widget.emailError = Text(
                        "There is an error with your email or password",
                        style: TextStyle(color: Colors.red));
                    widget.passError = Text(
                        "There is an error with your email or password",
                        style: TextStyle(color: Colors.red));
                  });
                } else {
                  if (password.text.length < 8) {
                    setState(() {
                      widget.emailError = Text(
                          "There is an error with your email or password",
                          style: TextStyle(color: Colors.red));
                      widget.passError = Text(
                          "There is an error with your email or password",
                          style: TextStyle(color: Colors.red));
                    });
                  } else if ((await Auth.checkUser(
                          email.text, password.text)) ==
                      null) {
                    setState(() {
                      widget.emailError = Text(
                          "There is an error with your email or password",
                          style: TextStyle(color: Colors.red));
                      widget.passError = Text(
                          "There is an error with your email or password",
                          style: TextStyle(color: Colors.red));
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
            GymButton(
              func: () {
                Navigator.pushNamed(context, '/register');
              },
              text: Center(
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
