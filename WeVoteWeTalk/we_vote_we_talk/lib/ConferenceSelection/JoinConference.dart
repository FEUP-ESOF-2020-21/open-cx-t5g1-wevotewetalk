import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import '../MainMenu.dart';

class JoinConference extends StatefulWidget {

  final user_id;
  UserData userData;
  JoinConference({this.user_id, this.userData});


  @override
  _JoinConferenceState createState() => _JoinConferenceState(user_id: user_id, userData: userData);
}

class _JoinConferenceState extends State<JoinConference> {

  final user_id;
  UserData userData;
  _JoinConferenceState({this.user_id,  this.userData});

  final _formKey = GlobalKey<FormState>();
  String conferenceCode = "";
  String error = "";
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    print("im in join");
    return Scaffold(
      appBar: AppBar(
        title: Text('We Vote We Talk'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              key: const Key('conferenceCode'),
              decoration:
              textInputDecoration.copyWith(hintText: 'Conference Code'),
              validator: (val) =>
              val.isEmpty ? 'Enter a valid code' : null,
              onChanged: (val) {
                setState(() => conferenceCode = val);
              },
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Join Talk',
                  style: TextStyle(color: Colors.white),
                  key: const Key('joinButton'),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    int result = await DatabaseService(user_id, conferenceCode).existsConferenceWithoutUser();
                    switch (result)
                    {
                      case 0:
                        DatabaseService(user_id, conferenceCode).addUserToTalk(userData);
                        userData.addConference(conferenceCode);
                        DatabaseService(user_id, conferenceCode).updateUser(userData);
                        navigateToMainMenu();
                        break;
                      case 1:
                        setState(() {
                        error = "Conference does not exist.";
                        });
                        break;
                      case 2:
                        setState(() {
                        error = "You have already joined this conference.";
                        });
                        break;
                      default:
                        break;
                    }
                  }
                  else{
                    setState(() {
                      conferenceCode = "";
                      error = "Insert a conference code.";
                    });
                  }
                }),
            SizedBox(height: 12.0),
          ],
        ),
      ),
    );


  }

  Future navigateToMainMenu() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id, talk_id: conferenceCode)));
  }

}