import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PollPage.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  Widget loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: ()  {Navigator.of(context).pushNamedAndRemoveUntil('/poll_page', (Route<dynamic> route)=>false);},
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: Colors.indigo,
        splashColor: Colors.white,
        highlightColor: Colors.white,
        minWidth: 200.0,
        height: 45.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: TextField(
        obscureText: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: TextField(
        obscureText: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
          height: 500.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              new Container(
                child: Text(
                  '\nLogin:\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                  ),
                ),
              ),
              new Container(
                  child: new Column(
                    children: <Widget>[
                      emailInput(),
                      passwordInput(),
                      loginButton(),
                    ],
                  ))
            ],
          )), // This trailing comma mak
      // es auto-formatting nicer for build methods.
    );
  }
}