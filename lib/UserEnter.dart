import 'package:flutter/material.dart';
import 'Register.dart';
import 'Login.dart';
import 'GymPageRoute.dart';
class UserEnter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: new BoxDecoration(boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                ),
              ]),
              child: Card(
                  elevation: 2.0,
                  margin: EdgeInsets.all(0.0),
                  child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
                      child: TabBar(
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(
                              child: Text("Login",
                                  style: const TextStyle(fontSize: 17.0))),
                          Tab(
                              child: Text("Register",
                                  style: const TextStyle(fontSize: 18.0))),
                        ],
                      ))),
            ),
          ),
          appBar: AppBar(
            elevation: 0.0,
            title: Text("GymBook", style: TextStyle(fontSize: 50.0),),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[800],
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Card(
                child: TabBarView(
                  children: [
                    Login(),
                    Register(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}