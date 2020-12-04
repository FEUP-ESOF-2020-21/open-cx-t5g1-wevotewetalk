import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import '../MainMenu.dart';

class CreateConference extends StatefulWidget {

  final user_id;
  UserData userData;
  CreateConference({this.user_id, this.userData});


  @override
  _CreateConferenceState createState() => _CreateConferenceState(user_id: user_id, userData: userData);
}

class _CreateConferenceState extends State<CreateConference> {

  final user_id;
  UserData userData;
  _CreateConferenceState({this.user_id, this.userData});

  final _formKey = GlobalKey<FormState>();
  String conferenceName = "";
  String error = "";
  bool loading = false;
  String confCode;


  @override
  Widget build(BuildContext context) {
    print("im in create");
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
              key: const Key('conferenceName'),
              decoration:
              textInputDecoration.copyWith(hintText: 'Conference Name'),
              validator: (val) =>
              val.isEmpty ? 'Enter a name' : null,
              onChanged: (val) {
                setState(() => conferenceName = val);
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
                  'Create Conference',
                  style: TextStyle(color: Colors.white),
                  key: const Key('createButton'),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    confCode = DatabaseService(user_id, "").createConference(conferenceName, userData);
                    userData.addConference(confCode);
                    DatabaseService(user_id, confCode).updateUser(userData);
                    navigateToMainMenu();
                  }
                  else{
                    setState(() {
                      conferenceName = "";
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id, talk_id: confCode)));
  }

}