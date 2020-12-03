import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Authentication/Auth.dart';
import 'package:we_vote_we_talk/Shared/GenericWidgets.dart';
import 'package:we_vote_we_talk/Voting/Voting.dart';

import '../MainMenu.dart';
import 'JoinConference.dart';

class ConferenceSelect extends StatefulWidget {
  final user_id;
  ConferenceSelect({this.user_id});


  @override
  _ConferenceSelectState createState() => _ConferenceSelectState(user_id: this.user_id);
}

class _ConferenceSelectState extends State<ConferenceSelect> {
  final AuthService _auth = AuthService();
  final user_id;

  _ConferenceSelectState({this.user_id});


  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('We Vote We Talk'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button('Join Conference', navigateToJoinConference),
                    button('Create Conference', createConference)
                  ]
              )
          )
      );

  }

  Future navigateToJoinConference() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => JoinConference(user_id: user_id)));
  }

  Future createConference() async {
    //criar nova conferencia

    Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id)));
  }

}