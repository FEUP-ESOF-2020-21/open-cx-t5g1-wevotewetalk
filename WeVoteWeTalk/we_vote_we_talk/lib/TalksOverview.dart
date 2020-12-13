import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
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
                  List<Idea> ideasList = snapshot.data;

                  ideasList.sort((a, b) => b.votes.compareTo(a.votes));
                  for (int i = 0; i < ideasList.length; i++) {
                    if (ideasList[i].name != null) talks.add(
                        ideasList[i].name + " - " +
                            ideasList[i].votes.toString() + " Votes");
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
