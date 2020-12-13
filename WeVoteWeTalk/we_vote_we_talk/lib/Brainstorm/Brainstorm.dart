import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import '../Shared/Idea.dart';
import 'IdeasList.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:provider/provider.dart';

import 'IdeaInput.dart';

class Brainstorm extends StatefulWidget {

  final user_id;
  final talk_id;
  Brainstorm({this.user_id, this.talk_id});

  @override
  _BrainstormState createState() => _BrainstormState(user_id: this.user_id, talk_id: this.talk_id);
}

class _BrainstormState extends State<Brainstorm> {

  final user_id;
  final talk_id;

  _BrainstormState({this.user_id, this.talk_id});


  TextEditingController tecThemeIdea = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConferenceData>(
      stream: DatabaseService(user_id, talk_id).conferenceData,
      builder: (context, snapshot) {
        ConferenceData conferenceData = snapshot.data;
        if(conferenceData.brainstorm)
        {
          return StreamProvider<List<Idea>>.value(
              value: DatabaseService(user_id, talk_id).ideas,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('We Vote We Talk'),
                  backgroundColor: Color(0xFF106799),
                ),
                body: Column(children: [
                  SizedBox(height: 15,),
                  Expanded(flex: 6, child: IdeasList()),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: IdeaInput(
                                      formKey: formKey, tecThemeIdea: tecThemeIdea)),
                              Expanded(flex: 3, child: sendButton()),
                            ],
                          ),
                        ],
                      )),
                ]),
              ));
        }
        else
          return Scaffold(
                appBar: AppBar(
                    title: Text('We Vote We Talk'),
                    backgroundColor: Color(0xFF106799),
                ),
                body: Center(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Brainstorm was closed by the Moderator.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        Text('Please return to The main Menu.', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                      ],
                    )
                  )
          );

      }
    );
  }

  Widget sendButton() {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child: MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text('Send'),
          onPressed: () {
            sendThemeIdea();
          },
          minWidth: 200.0,
          height: 45.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ));
  }

  sendThemeIdea() async {
    if (formKey.currentState.validate()) {
      await DatabaseService(user_id, talk_id).addIdea(tecThemeIdea.text, 0);
      tecThemeIdea.text = "";
    }
  }
}
