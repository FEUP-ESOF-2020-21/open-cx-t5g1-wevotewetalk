import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
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

  final user_id;
  UserData userData;
  _EnterConferenceState({this.user_id,  this.userData});

  var conferences = new List();

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    print("im in enter");
    print(userData.joinedConferences);
    conferences = List.from(userData.joinedConferences);

    return Scaffold(
        appBar: AppBar(
            title: Text('We Vote We Talk'),
            backgroundColor: Color(0xFF106799),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Your joined conferences:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),),
                SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  children: getListTalks(),
                ),
              ],
            )
        )
    );
  }

  List<Widget> getListTalks() {
    List<Widget> list = new List();
    for (var conference in conferences) {
      list.add(conferenceButton(conference));
    }
    return list;
  }

  Widget conferenceButton(conference) {

    print("conferene id in button: " +conference);

    return StreamBuilder<Object>(
      stream: DatabaseService(user_id, conference).conferenceData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          ConferenceData conferenceData = snapshot.data;
          print("conferene name in button: " +conferenceData.name);
          return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              child: MaterialButton(
                textColor: Colors.white,
                color: Colors.black87,
                child: Text(conferenceData.name),
                onPressed: () {
                  navigateToConference(conference);
                },
                minWidth: 200.0,
                height: 45.0,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ));
        }
        else
          return Loading();
      }
    );
  }

  Future navigateToConference(conference) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id, talk_id: conference)));
  }

}