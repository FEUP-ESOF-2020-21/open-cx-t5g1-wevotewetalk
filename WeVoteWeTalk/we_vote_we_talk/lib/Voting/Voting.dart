import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/Shared/GenericWidgets.dart';
import '../Shared/Idea.dart';
import 'VotingList.dart';
import '../Database.dart';

class Voting extends StatefulWidget {

  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Idea>>.value(
        value: DatabaseService().ideas,
        child: Scaffold(
          appBar: AppBar(
            title: Text('We Vote We Talk'),
          ),
          body: Column(children: [
            Expanded(
                flex: 6,
                child: VotingList()),
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
        )
    );
  }

  Future navigateBackToMainMenu() async {
    Navigator.pop(context);
  }

}