import 'package:flutter/material.dart';
import 'GymButton.dart';
import 'Auth.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);
  Text error = Text("");
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
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 18.0, right: 18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Align(
                      child: Text('Register',
                          style: TextStyle(color: Colors.white, fontSize: 40.0)),
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
                      var reg1 = RegExp(r'[0-9]+');
                      var reg2 = RegExp(r'[A-Z]+');
                      var reg3 = RegExp(r'[a-z]+');
                      var reg4 = RegExp(r'[\W_]+');
                      if (email.text.isEmpty) {
                        setState(() {
                          widget.error = Text("You have to enter an email",
                              style: TextStyle(color: Colors.red, fontSize: 18.0));
                        });
                      }
                      else if ((await Auth.isUser(email.text.toLowerCase()))) {
                        setState(() {
                          widget.error = Text(
                              "There is already an account with that email, try another!",
                              style: TextStyle(color: Colors.red, fontSize: 18.0));
                        });
                      }
                      else {
                        if (name.text.isEmpty) {
                          setState(() {
                            widget.error = Text("You have to enter a name!",
                                style: TextStyle(color: Colors.red, fontSize: 18.0));
                          });
                        }
                        else {
                          if (password.text.length < 8) {
                            setState(() {
                              widget.error = Text(
                                  "Your chosen password is too short",
                                  style: TextStyle(color: Colors.red, fontSize: 18.0));
                            });
                          }
                          else if(reg1.allMatches(password.text).length == 0){
                            setState(() {
                              widget.error = Text(
                                  "Your password needs to have atleast 1 uppercase, 1 lowercase, 1 number and one non-alphanumeric character (e.g !, ? or |)",
                                  style: TextStyle(color: Colors.red, fontSize: 18.0));
                            });

                          }
                          else if(reg2.allMatches(password.text).length == 0){
                            setState(() {
                              widget.error = Text(
                                  "Your password needs to have atleast 1 uppercase, 1 lowercase, 1 number and one non-alphanumeric character (e.g !, ? or |)",
                                  style: TextStyle(color: Colors.red, fontSize: 18.0));
                            });
                          }
                          else if(reg3.allMatches(password.text).length == 0){
                            setState(() {
                              widget.error = Text(
                                  "Your password needs to have atleast 1 uppercase, 1 lowercase, 1 number and one non-alphanumeric character (e.g !, ? or |)",
                                  style: TextStyle(color: Colors.red, fontSize: 18.0));
                            });
                          }
                          else if(reg4.allMatches(password.text).length == 0){
                            setState(() {
                              widget.error = Text(
                                  "Your password needs to have atleast 1 uppercase, 1 lowercase, 1 number and one non-alphanumeric character (e.g !, ? or |)",
                                  style: TextStyle(color: Colors.red, fontSize: 18.0));
                            });
                          }
                          else {
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
                ],
              ),
            ),
          ),
        ));
  }
}
