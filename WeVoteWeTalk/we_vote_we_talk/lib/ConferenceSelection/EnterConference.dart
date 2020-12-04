import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import '../MainMenu.dart';

class EnterConference extends StatefulWidget {

  final user_id;
  UserData userData;
  EnterConference({this.user_id, this.userData});


  @override
  _EnterConferenceState createState() => _EnterConferenceState(user_id: user_id, userData: userData);
}

class _EnterConferenceState extends State<EnterConference> {

  var conferences = new List();

  final user_id;
  UserData userData;
  _EnterConferenceState({this.user_id,  this.userData});

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    print("im in enter");
    print(userData.joinedConferences);
    return Scaffold(
        appBar: AppBar(
          title: Text('We Vote We Talk'),
        ),
        body: Center(
            child: ListView(
              shrinkWrap: true,
              children: getListTalks(),
            )));
  }

  List<Widget> getListTalks() {
    List<Widget> list = new List();
    for (var conference in userData.joinedConferences) {
      list.add(conferenceButton(conference));
    }
    return list;
  }

  Widget conferenceButton(conference) {

    String name = DatabaseService(user_id, conference).getConferenceName();

    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        child: MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text(name),
          onPressed: () {
            navigateToConference(conference);
          },
          minWidth: 200.0,
          height: 45.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ));
  }

  Future navigateToConference(conference) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id, talk_id: conference)));
  }

}