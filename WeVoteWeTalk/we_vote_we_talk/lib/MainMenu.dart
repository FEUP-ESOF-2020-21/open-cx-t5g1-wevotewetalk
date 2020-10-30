import 'package:flutter/material.dart';

import 'Brainstorm.dart';
import 'GenericWidgets.dart';
import 'ModeratorOptions.dart';
import 'StartPage.dart';
import 'TalksOverview.dart';
import 'Vote.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _moderator = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _moderator ? moderatorUser() : generalUser(),
            )
        )
    );
  }

  List<Widget> generalUser(){
    List<Widget> list = new List();
    list.add(button('Brainstorm', navigateToBrainstorm));
    list.add(button('Vote', navigateToVote));
    list.add(button('Join Talks', navigateToTalks));
    list.add(button('Sign Out', navigateToStartPage));
    return list;
  }

  List<Widget> moderatorUser(){
    List<Widget> list = new List();
    list.add(button('Brainstorm', navigateToBrainstorm));
    list.add(button('Vote', navigateToVote));
    list.add(button('Join Talks', navigateToTalks));
    list.add(button('Moderator Options', navigateToModeratorOptions));
    list.add(button('Sign Out', navigateToStartPage));
    return list;
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

  Future navigateToModeratorOptions() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ModeratorOptions()));
  }

  Future navigateToStartPage() async {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StartPage()), (Route<dynamic> route) => false);
  }

}