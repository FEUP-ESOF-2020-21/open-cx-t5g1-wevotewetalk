import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MainMenu.dart';


class SignInForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('We Vote We Talk'),
        ),
        body: new ListView(
          children: getListWidgets(context),
        )

    );
  }

  List<Widget> getListWidgets(context) {
    List<Widget> list = new List();

    list.add(title());
    list.add(emailInput());
    list.add(passwordInput());
    list.add(signInButton(context));

    return list;
  }

  Widget title() {
    return Text(
      '\nSign in\n',
      style: TextStyle(fontSize: 32.0,),
      textAlign: TextAlign.center,
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

  Widget signInButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: ()  {
          navigateToMainMenu(context);
        },
        child: Text(
          "Sign in",
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

  Future navigateToMainMenu(context) async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainMenu()), (Route<dynamic> route) => false);
  }
}