import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Register.dart';
import 'Shared/User.dart';
import 'Authentication/Auth.dart';
import 'Brainstorm/Brainstorm.dart';
import 'Database.dart';
import 'Shared/Loading.dart';
import 'shared/GenericWidgets.dart';
import 'Moderator/ModeratorOptions.dart';
import 'TalksOverview.dart';
import 'package:we_vote_we_talk/Voting/Voting.dart';

class MainMenu extends StatefulWidget {
  final user_id;
  MainMenu({this.user_id});


  @override
  _MainMenuState createState() => _MainMenuState(user_id: this.user_id);
}

class _MainMenuState extends State<MainMenu> {
  bool _moderator = true;
  final AuthService _auth = AuthService();
  final user_id;

  _MainMenuState({this.user_id});


  @override
  Widget build(BuildContext context) {
    print("MainMenu");
    print(user_id);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user_id).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
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
                          Text('Welcome ' + userData.name + '!',),
                          SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:_moderator ? moderatorUser() : generalUser(),
                          )
                        ]

                    )
                )
            );
          } else {
            return Loading();
          }
        }
    );
  }

  List<Widget> generalUser(){
    List<Widget> list = new List();
    list.add(button('Brainstorm', navigateToBrainstorm));
    list.add(button('Themes Vote', navigateToVote));
    list.add(button('Join Talks', navigateToTalks));
    return list;
  }

  List<Widget> moderatorUser(){
    List<Widget> list = new List();
    list.add(button('Brainstorm', navigateToBrainstorm));
    list.add(button('Vote', navigateToVote));
    list.add(button('Join Talks', navigateToTalks));
    list.add(button('Moderator Options', navigateToModeratorOptions));
    return list;
  }

  Future navigateToBrainstorm() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Brainstorm()));
  }

  Future navigateToVote() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Voting(user_id: user_id)));
  }

  Future navigateToTalks() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TalksOverview()));
  }

  Future navigateToModeratorOptions() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ModeratorOptions()));
  }

}