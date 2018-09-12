import 'package:flutter/material.dart';
import 'GymButton.dart';
import 'Auth.dart';

class Register extends StatefulWidget {
  Text emailError = Text("");
  Text passError = Text("");
  Text nameError = Text("");
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.grey[800],
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                Container(
                  child: Align(
                    child: Text('Register',
                        style: TextStyle(color: Colors.white, fontSize: 60.0)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    "Email",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        height: 2.0),
                  ),
                ),
                TextField(
                  controller: email,
                  style: TextStyle(color: Colors.black),
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(),
                      hintText: "Email"),
                ),
                widget.emailError,
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    "Full Name",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        height: 2.0),
                  ),
                ),
                TextField(
                  controller: name,
                  style: TextStyle(color: Colors.black),
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(),
                      hintText: "Name"),
                ),
                widget.nameError,
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    "Password",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        height: 2.0),
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
                        widget.nameError = Text("");
                        widget.passError = Text("");
                      });
                    } else if ((await Auth.isUser(email.text.toLowerCase()))) {
                      setState(() {
                        widget.emailError = Text(
                            "There is already an account with that email, try another!",
                            style: TextStyle(color: Colors.red));
                        widget.nameError = Text("");
                        widget.passError = Text("");
                      });
                    } else {
                      if (name.text.isEmpty) {
                        setState(() {
                          widget.nameError = Text("You have to enter a name!",
                              style: TextStyle(color: Colors.red));
                          widget.emailError = Text("");
                          widget.passError = Text("");
                        });
                      } else {
                        if (password.text.length < 8) {
                          setState(() {
                            widget.nameError = Text("");
                            widget.emailError = Text("");
                            widget.passError = Text(
                                "Your chosen password is too short",
                                style: TextStyle(color: Colors.red));
                          });
                        } else {
                          await Auth.newUser(email.text, name.text,
                              '${DateTime.now()}', password.text);
                          await Auth.loginUser(email.text, password.text);
                          Navigator.pushNamed(context, '/home');
                        }
                      }
                    }
                  },
                  text: Center(
                    child: Text('Register'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 170.0, bottom: 170.0),
                ),
              ],
            ),
          ),
        ));
  }
}
