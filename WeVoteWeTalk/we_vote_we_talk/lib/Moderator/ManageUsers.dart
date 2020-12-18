import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'package:we_vote_we_talk/Shared/Constants.dart';
import 'package:we_vote_we_talk/Shared/Idea.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import 'package:we_vote_we_talk/Shared/User.dart';

class ManageUsers extends StatefulWidget {

  final user_id;
  final talk_id;

  ManageUsers({this.user_id, this.talk_id});

  @override
  _ManageUsersState createState() => _ManageUsersState(user_id: this.user_id, talk_id: this.talk_id);
}

class _ManageUsersState extends State<ManageUsers> {

  final _formKey = GlobalKey<FormState>();
  final user_id;
  final talk_id;

  _ManageUsersState({this.user_id, this.talk_id});

  String _currentName;
  bool _exit = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConferenceData>(
        stream: DatabaseService(user_id, talk_id).conferenceData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ConferenceData conferenceData = snapshot.data;
            return StreamBuilder<List<ConferenceUserData>>(
                stream: DatabaseService(user_id, talk_id).conferenceAllUsersData,
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<ConferenceUserData> conferenceAllUsersData = snapshot.data;
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
                                itemCount: conferenceAllUsersData.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Text(conferenceAllUsersData[index].name, textAlign: TextAlign.center, style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.w400),)
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: selectButton(conferenceAllUsersData[index], conferenceData),
                                      ),
                                    ],
                                  );
                                }
                            )
                        ),
                      ]),
                    );
                  }
                  else
                    return Loading();
                }
            );
          }
          else
            return Loading();
        }
    );

  }

  Widget selectButton(ConferenceUserData conferenceUserData, ConferenceData conferenceData) {
    if(!conferenceUserData.moderator)
      return IconButton(
          icon:Icon(conferenceData.isBanned(conferenceUserData.uid) ?
          Icons.person_add_alt_1 : Icons.person_remove),
          onPressed: () async {
            if(conferenceData.isBanned(conferenceUserData.uid))
            {
              if(!conferenceUserData.moderator)
                conferenceData.unban(conferenceUserData.uid);
              await DatabaseService(user_id, talk_id).updateConference(conferenceData);
            }
            else
            {
              if(!conferenceUserData.moderator)
                conferenceData.ban(conferenceUserData.uid);
              await DatabaseService(user_id, talk_id).updateConference(conferenceData);
            }
          }
      );
    else
      return IconButton(
        icon:Icon(Icons.admin_panel_settings),
        onPressed: () {},
      );


  }

  Future navigateBackToModeratorOptions() async {
    Navigator.pop(context);
  }
}




