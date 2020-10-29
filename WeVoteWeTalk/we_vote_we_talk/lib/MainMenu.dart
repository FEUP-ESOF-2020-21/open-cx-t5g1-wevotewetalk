import 'package:flutter/material.dart';

import 'Brainstorm.dart';
import 'GenericWidgets.dart';
import 'TalksOverview.dart';
import 'Vote.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button('Brainstorm', navigateToBrainstorm),
                button('Vote', navigateToVote),
                button('Join Talks', navigateToTalks),
              ],
            )
        )
    );
  }

  Future navigateToBrainstorm() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Brainstorm()));
  }

  Future navigateToVote() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Vote()));
  }

  Future navigateToTalks() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TalksOverview()));
  }

}