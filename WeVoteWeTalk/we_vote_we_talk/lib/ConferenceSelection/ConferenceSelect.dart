import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Authentication/Auth.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/GenericWidgets.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import 'package:we_vote_we_talk/Voting/Voting.dart';

import '../Login.dart';
import '../MainMenu.dart';
import 'CreateConference.dart';
import 'EnterConference.dart';
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
  UserData userData;
  _ConferenceSelectState({this.user_id});


  @override
  Widget build(BuildContext context) {
      print("Conference select");
      print(user_id);
      return StreamBuilder<Object>(
        stream: DatabaseService(user_id, "").userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            userData = snapshot.data;
            print(userData.joinedConferences);
            return Scaffold(
                appBar: AppBar(
                  title: Text('We Vote We Talk'),
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
                        children: [
                          button('Join Conference', navigateToJoinConference),
                          button('Create Conference', createConference),
                          button('Enter Conference', enterConference),
                        ]
                    )
                )
            );
          }
          else
            return Loading();
        }
      );

  }

  Future navigateToJoinConference() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => JoinConference(user_id: user_id, userData: userData)));
  }

  Future createConference() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateConference(user_id: user_id, userData: userData)));
  }

  Future enterConference() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EnterConference(user_id: user_id, userData: userData)));
  }

  Future navigateBackToLogin() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
    );
  }

}