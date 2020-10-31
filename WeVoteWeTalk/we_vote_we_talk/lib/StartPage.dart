import 'package:flutter/material.dart';
import 'Login.dart';
import 'SignInForm.dart';
import 'SignUpForm.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              Expanded(
                  flex: 7,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome to We Vote We Talk', textScaleFactor: 1.8,),
                    ],
                  )

              ),
              Expanded(
                flex: 3,
                child: new ListView(
                  children: <Widget> [
                    signInButton(context),
                    signUpButton(context),
                  ],
                ),
              ),
            ],
          )
      ),

    );
  }

  Widget signInButton(BuildContext context){
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        child:MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text('Sign in'),
          onPressed: () {
            navigateToLogin(context);
          },
          minWidth: 200.0,
          height: 45.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        )
    );
  }

  Widget signUpButton(BuildContext context){
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        child:MaterialButton(
          textColor: Colors.white,
          color: Colors.indigo,
          child: Text('Sign up'),
          onPressed: () {
            navigateToRegister(context);
          },
          minWidth: 200.0,
          height: 45.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        )
    );
  }

  Future navigateToLogin(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future navigateToRegister(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpForm()));
  }
}
