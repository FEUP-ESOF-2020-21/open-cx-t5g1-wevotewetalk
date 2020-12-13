import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Authentication/Auth.dart';

import '../main.dart';
import '../shared/GenericWidgets.dart';
import 'ManageUsers.dart';
import 'ManageSchedule.dart';
import 'OrderVotes.dart';
import 'ManageIdeas.dart';

class ModeratorOptions extends StatefulWidget {
  @override
  _ModeratorOptionsState createState() => _ModeratorOptionsState();
}

class _ModeratorOptionsState extends State<ModeratorOptions> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('We Vote We Talk'),
          backgroundColor: Color(0xFF106799),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
                navigateBackToLogin();
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options(),
            )
        )
    );
  }

  List<Widget> options(){
    List<Widget> list = new List();
    list.add(button('Close Brainstorm and Manage Ideas', navigateToManageIdeas));
    list.add(button('Close Voting and Manage Schedule', navigateToManageSchedule));
    list.add(button('Manage Users', navigateToBanUser));
    return list;
  }



  Future navigateToManageIdeas() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageIdeas()));
  }

  Future navigateToManageSchedule() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageSchedule()));
  }

  Future navigateToBanUser() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsers()));
  }

  Future navigateBackToLogin() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
          (Route<dynamic> route) => false,
    );
  }

}
