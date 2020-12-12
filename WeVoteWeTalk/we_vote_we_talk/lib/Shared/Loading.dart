import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:we_vote_we_talk/Authentication/Auth.dart';

import '../main.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
        appBar: AppBar(
                      title: Text('We Vote We Talk'),
                      backgroundColor: Color(0xFF106799),
        ),
        body: InkWell(
          onTap: () async {
            await _auth.signOut();
            navigateBackToLogin(context);
          },
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: SpinKitFoldingCube(
                color: Colors.blue,
                duration: Duration(milliseconds: 350),
                size: 50.0,
              ),
            ),
          )
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