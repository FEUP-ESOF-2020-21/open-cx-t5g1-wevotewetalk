import 'package:flutter/material.dart';
import 'package:we_vote_we_talk/Shared/Conference.dart';
import 'package:we_vote_we_talk/Shared/GenericWidgets.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import '../Shared/Idea.dart';
import '../Database.dart';

class Voting extends StatefulWidget {

  final user_id;
  final talk_id;
  Voting({this.user_id, this.talk_id});


  @override
  _VotingState createState() => _VotingState(user_id: user_id, talk_id: talk_id);
}

class _VotingState extends State<Voting> {

  final user_id;
  final talk_id;
  _VotingState({this.user_id, this.talk_id});


  @override
  Widget build(BuildContext context) {
    print("Voting");
    return StreamBuilder<ConferenceData>(
        stream: DatabaseService(user_id, talk_id).conferenceData,
        builder: (context, snapshot) {
          ConferenceData conferenceData = snapshot.data;
          if(conferenceData.voting)
          {
            return StreamBuilder<ConferenceUserData>(
                stream: DatabaseService(user_id, talk_id).conferenceUserData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ConferenceUserData userData = snapshot.data;
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
                                                  flex: 9,
                                                  child: Text(
                                                    ideas[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.w400),
                                                  )
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    icon:
                                                    Icon(userData.hasVoted(
                                                        ideas[index].name) ? Icons
                                                        .favorite_outlined : Icons
                                                        .favorite_border_outlined),
                                                    onPressed: () async {
                                                      if (userData.hasVoted(
                                                          ideas[index].name)) {
                                                        await DatabaseService(user_id, talk_id).updateIdeas(ideas[index].name, ideas[index].votes - 1, ideas[index].documentID, ideas[index].index);
                                                        userData.removeIdea(ideas[index].name);
                                                      }
                                                      else {
                                                        await DatabaseService(user_id, talk_id).updateIdeas(ideas[index].name, ideas[index].votes + 1, ideas[index].documentID, ideas[index].index);
                                                        userData.vote(ideas[index].name);
                                                      }

                                                      await DatabaseService(
                                                          user_id, talk_id)
                                                          .updateUserTalk(
                                                          userData);
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
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child:
                                      button('Main Menu', navigateBackToMainMenu)
                                  )
                              )
                            ]),
                          );
                        }
                    );
                  } else {
                    return Loading();
                  }
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
                        Text('Voting was closed by the Moderator.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                        Text('Please return to The main Menu.', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                      ],
                    )
                )
            );
        }
    );
  }

  Future navigateBackToMainMenu() async {
    Navigator.pop(context);
  }

}