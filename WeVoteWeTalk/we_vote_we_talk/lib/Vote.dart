import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/GenericWidgets.dart';

class Vote extends StatefulWidget {

  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
          children: [
            new ListView(

            ),
            button('Main Menu', navigateBackToMainMenu)
          ]
      ), // This trailing comma mak
      // es auto-formatting nicer for build methods.
    );
  }

  Future navigateBackToMainMenu() async {

  }

}