import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'Shared/User.dart';
import 'Authentication/Auth.dart';
import 'Brainstorm/Brainstorm.dart';
import 'Database.dart';
import 'Shared/Loading.dart';
import 'main.dart';
import 'Shared/GenericWidgets.dart';
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
            return StreamBuilder<ConferenceData>(
              stream: DatabaseService(user_id, talk_id).conferenceData,
              builder: (context, snapshot) {
                ConferenceData conferenceData = snapshot.data;
                if(!conferenceData.isBanned(user_id))
                {
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('You\'re in ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                                      Text(conferenceData.name, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Color(0xFF106799)),),
                                      Text('!', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                                    ],
                                  ),
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
                                    children: getButtons(conferenceData, userData.moderator),
                                  ),
                                  SizedBox(height: 30),
                                ]
                            ),
                          )
                      )
                  );
                }
                else
                  return Text("banned lol");

              }
            );
          } else {
            return Loading();
          }
        }

    );
  }

  List<Widget> getButtons(ConferenceData conferenceData, bool isModerator){
    List<Widget> list = new List();

    if(conferenceData.brainstorm)
      list.add(button('Brainstorm', navigateToBrainstorm));
    else
      list.add(closedButton('Brainstorm'));

    if(conferenceData.voting)
      list.add(button('Vote', navigateToVote));
    else
      list.add(closedButton('Vote'));

    if(conferenceData.joinTalks)
      list.add(button('Join Sessions', navigateToTalks));
    else
      list.add(closedButton('Join Sessions'));

    if(isModerator)
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => ModeratorOptions(user_id: user_id, talk_id: talk_id)));
  }

  Future navigateBackToLogin() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => App()),
          (Route<dynamic> route) => false,
    );
  }

}