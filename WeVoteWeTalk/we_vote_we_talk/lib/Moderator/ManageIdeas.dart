import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/Idea.dart';

class ManageIdeas extends StatefulWidget {

  final user_id;
  final talk_id;

  ManageIdeas({this.user_id, this.talk_id});

  @override
  _ManageIdeasState createState() => _ManageIdeasState(user_id: this.user_id, talk_id: this.talk_id);
}

class _ManageIdeasState extends State<ManageIdeas> {

  final _formKey = GlobalKey<FormState>();
  final user_id;
  final talk_id;

  _ManageIdeasState({this.user_id, this.talk_id});

  String _currentName;
  bool _exit = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConferenceData>(
        stream: DatabaseService(user_id, talk_id).conferenceData,
        builder: (context, snapshot) {
          ConferenceData conferenceData = snapshot.data;
          if(!_exit)
            DatabaseService(user_id, talk_id).updateConference(ConferenceData(conferenceData.name, false, false, false, conferenceData.banned));
          return StreamBuilder<List<Idea>>(
            stream: DatabaseService(user_id, talk_id).ideas,
            builder: (context, snapshot) {
              List<Idea> ideas = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: Text('We Vote We Talk'),
                  backgroundColor: Color(0xFF106799),
                ),
                body: Column(children: [
                  Expanded(
                      flex: 6,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: ideas.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Text(ideas[index].name, textAlign: TextAlign.center, style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.w400),)
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                        icon:
                                        Icon(Icons.edit),
                                        onPressed: () => showModalBottomSheet(context: context, builder: (context) {
                                          return Form(
                                            key: _formKey,
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: 10.0,),
                                                Text('Rename Idea:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                                                SizedBox(height: 10.0,),
                                                TextFormField(
                                                  initialValue: ideas[index].name,
                                                  decoration: textInputDecoration,
                                                  validator: (val) => val.isEmpty || isRepeated(_currentName, ideas)? 'Please enter new idea' : null,
                                                  onChanged: (val) => setState(() => _currentName = val),
                                                ),
                                                SizedBox(height: 10.0),
                                                RaisedButton(
                                                    color: Colors.pink[400],
                                                    child: Text(
                                                      'Rename',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    onPressed: () async {
                                                      if(_formKey.currentState.validate()){
                                                          await DatabaseService(user_id, talk_id).updateIdeas(_currentName, ideas[index].votes, ideas[index].documentID);
                                                          Navigator.pop(context);
                                                      }
                                                    }
                                                ),
                                              ],
                                            ),
                                          );
                                        }),

                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        icon:
                                        Icon(Icons.delete),
                                        onPressed: () async {
                                          await DatabaseService(user_id, talk_id).removeIdea(ideas[index].documentID);
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 20.0,
                          ),
                          child:MaterialButton(
                            textColor: Colors.white,
                            color: Colors.green,
                            child: Text('Finish and Open Voting'),
                            onPressed: () async {
                              _exit = true;
                              await DatabaseService(user_id, talk_id).updateConference(ConferenceData(conferenceData.name, false, true, false, conferenceData.banned));
                              navigateBackToModeratorOptions();
                            },
                            minWidth: 200.0,
                            height: 45.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          )
                      ),
                  )
                ]),
              );
            }
          );
        }
    );

  }

  isRepeated(value, ideas) {
    for (int i = 0; i < ideas.length; i++) {
      if (ideas[i].name == value) return true;
    }
    return false;
  }

  Future navigateBackToModeratorOptions() async {
    Navigator.pop(context);
  }
}




