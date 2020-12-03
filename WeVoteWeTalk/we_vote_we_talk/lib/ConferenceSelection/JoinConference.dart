import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import '../MainMenu.dart';

class JoinConference extends StatefulWidget {

  final user_id;
  JoinConference({this.user_id});


  @override
  _JoinConferenceState createState() => _JoinConferenceState(user_id: user_id);
}

class _JoinConferenceState extends State<JoinConference> {

  final user_id;
  _JoinConferenceState({this.user_id});

  final _formKey = GlobalKey<FormState>();
  String conferenceCode = "";
  String error = "";
  bool loading = false;


  @override
  Widget build(BuildContext context) {
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
                    bool result = true;
                    //bool result = await //verificar se existe a conferencia;
                    if (result == true) {
                      navigateToMainMenu();
                    }
                  }
                  else{
                    setState(() {
                      conferenceCode = "";
                      error = "Wrong conference code.";
                    });
                  }
                }),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );


  }

  Future navigateToMainMenu() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(user_id: user_id)));
  }

}