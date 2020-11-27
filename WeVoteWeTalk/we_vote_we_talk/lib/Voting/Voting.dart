import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/Shared/GenericWidgets.dart';
import 'package:we_vote_we_talk/Shared/Loading.dart';
import 'package:we_vote_we_talk/Shared/User.dart';
import '../Shared/Idea.dart';
import 'VotingList.dart';
import '../Database.dart';

class Voting extends StatefulWidget {

  final user_id;
  Voting({this.user_id});


  @override
  _VotingState createState() => _VotingState(user_id: user_id);
}

class _VotingState extends State<Voting> {

  final user_id;
  _VotingState({this.user_id});


  @override
  Widget build(BuildContext context) {
    print("Voting");
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user_id).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return StreamBuilder<List<Idea>>(
              stream: DatabaseService().ideas,
              builder: (context, snapshot) {
                List<Idea> ideas = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('We Vote We Talk'),
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
                                  child: Padding(
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
                                            )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              icon:
                                              Icon(userData.hasVoted(ideas[index].name)? Icons.favorite_outlined : Icons.favorite_border_outlined),
                                              onPressed: () {
                                                setState(() async {
                                                  if(userData.hasVoted(ideas[index].name)) {
                                                    await DatabaseService().updateIdeas(ideas[index].name, ideas[index].votes-1, ideas[index].documentID);
                                                    userData.removeIdea(ideas[index].name);

                                                  }
                                                  else {
                                                    await DatabaseService().updateIdeas(ideas[index].name, ideas[index].votes+1, ideas[index].documentID);
                                                    userData.vote(ideas[index].name);
                                                  }
                                                });

                                              }
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            })),
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
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

  Future navigateBackToMainMenu() async {
    Navigator.pop(context);
  }

}