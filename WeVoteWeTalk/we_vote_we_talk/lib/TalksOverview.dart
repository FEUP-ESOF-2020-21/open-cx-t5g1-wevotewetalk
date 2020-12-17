import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import 'Database.dart';
import 'Shared/Idea.dart';
import 'TalkJoin.dart';
import 'Brainstorm/IdeasList.dart';


class TalksOverview extends StatefulWidget {
  final user_id;
  final talk_id;

  TalksOverview({this.user_id, this.talk_id});

  @override
  _TalksOverviewState createState() =>
      _TalksOverviewState(user_id: this.user_id, talk_id: this.talk_id);
}

class _TalksOverviewState extends State<TalksOverview> {
  var talks = new List();

  final user_id;
  final talk_id;

  var times = ['[10:00-11:00]','[11:30-12:30]','[14:00-15:00]','[15:30-16:30]','[17:00-18:00]'];

  _TalksOverviewState({this.user_id, this.talk_id});

  Widget build(BuildContext context) {


    return StreamBuilder<ConferenceData>(
        stream: DatabaseService(user_id, talk_id).conferenceData,
        builder: (context, snapshot) {
          ConferenceData conferenceData = snapshot.data;
          if(conferenceData.joinTalks)
          {
            return StreamBuilder<List<Idea>>(
                stream: DatabaseService(user_id, talk_id).ideas,
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<Idea> ideasList = snapshot.data;

                    ideasList.sort((a, b) => a.index.compareTo(b.index));

                    var j = -1;
                    for (int i = 0; i < ideasList.length && i < 15; i++) {
                      if(i % 3 == 0)
                        j++;
                      if (ideasList[i].name != null) talks.add(
                          ideasList[i].name + " " + times[j]);
                    }
                    return Scaffold(
                        appBar: AppBar(
                          title: Text('We Vote We Talk'),
                          backgroundColor: Color(0xFF106799),
                        ),
                        body: Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: getListTalks(),
                            )
                        )
                    );
                  }
                  else
                    return Loading();
                }
            );
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
                        Text('Join Talks was closed by the Moderator.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        Text('Please return to The main Menu.', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                      ],
                    )
                )
            );
        }
    );

  }

  List<Widget> getListTalks() {
    List<Widget> list = new List();
    for (var talk in talks) {
      list.add(talkButton(talk));
    }
    return list;
  }

  Widget talkButton(talk) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        child: MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text(talk),
          onPressed: () {
            navigateToTalk(talk);
          },
          minWidth: 200.0,
          height: 45.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ));
  }

  Future navigateToTalk(talk) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TalkJoin(talk: talk)));
  }
}
