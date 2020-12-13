import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Shared/User.dart';
import 'Authentication/Auth.dart';
import 'Brainstorm/Brainstorm.dart';
import 'Database.dart';
import 'Shared/Loading.dart';
import 'main.dart';
import 'shared/GenericWidgets.dart';
import 'Moderator/ModeratorOptions.dart';
import 'TalksOverview.dart';
import 'package:we_vote_we_talk/Voting/Voting.dart';

class MainMenu extends StatefulWidget {
  final user_id;
  final talk_id;
  MainMenu({this.user_id, this.talk_id});


  @override
  _MainMenuState createState() => _MainMenuState(user_id: this.user_id, talk_id: this.talk_id);
}

class _MainMenuState extends State<MainMenu> {
  final AuthService _auth = AuthService();
  final user_id;
  final talk_id;

  _MainMenuState({this.user_id, this.talk_id,});


  @override
  Widget build(BuildContext context) {
    print("MainMenu");
    print(user_id);
    print(talk_id);
    return StreamBuilder<ConferenceUserData>(
        stream: DatabaseService(user_id, talk_id).conferenceUserData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            ConferenceUserData userData = snapshot.data;
            print(userData.uid);
            print(userData.name);
            print(userData.votedIdeas);
            print(userData.moderator);
            return StreamBuilder<String>(
              stream: DatabaseService(user_id, talk_id).conferenceName,
              builder: (context, snapshot) {
                String talkName = snapshot.data;
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
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 200.0,
                                    height: 200.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/wevotewetalklogo.png'),
                                          fit: BoxFit.fill
                                      ),
                                    ),
                                ),
                                SizedBox(height: 30),
                                Text('Welcome ' + userData.name + '!',  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),) ,
                                SizedBox(height: 20),
                                Text('You\'re in ' + talkName + '!', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Code: ", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                                    SelectableText(talk_id, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                SizedBox(height: 25),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: userData.moderator ? moderatorUser() : generalUser(),
                                ),
                                SizedBox(height: 30),
                              ]
                          ),
                        )
                    )
                );
              }
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Brainstorm(user_id: user_id, talk_id: talk_id)));
  }

  Future navigateToVote() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Voting(user_id: user_id, talk_id: talk_id)));
  }

  Future navigateToTalks() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TalksOverview(user_id: user_id, talk_id: talk_id)));
  }

  Future navigateToModeratorOptions() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ModeratorOptions()));
  }

  Future navigateBackToLogin() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
          (Route<dynamic> route) => false,
    );
  }

}