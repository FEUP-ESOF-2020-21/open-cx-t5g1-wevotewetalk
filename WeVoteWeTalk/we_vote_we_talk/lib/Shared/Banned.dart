import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:we_vote_we_talk/Authentication/Auth.dart';

import '../main.dart';
import 'GenericWidgets.dart';

class Banned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
                      title: Text('We Vote We Talk'),
                      backgroundColor: Color(0xFF106799),
        ),
        body: Center(
          child: MaterialButton(
            textColor: Colors.white,
            color: Colors.red[800],
            child: Text('You were banned from this conference.\nClick here to exit.', textAlign: TextAlign.center,),
            onPressed: ()  {
              navigateBackToLogin(context);
            },
            minWidth: 200.0,
            height: 55.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          ),
        )
    );
  }

  Future navigateBackToLogin(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
          (Route<dynamic> route) => false,
    );
  }
}