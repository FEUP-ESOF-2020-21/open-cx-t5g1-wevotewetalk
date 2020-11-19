import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/shared/Loading.dart';
import '../Shared/Idea.dart';
import '../TalksOverview.dart';

class IdeasList extends StatefulWidget {
  @override
  _IdeasListState createState() => _IdeasListState();
}

class _IdeasListState extends State<IdeasList> {
  @override
  Widget build(BuildContext context) {
    final ideas = Provider.of<List<Idea>>(context);
    ideasList = ideas;
    if (ideas != null) {
      ideas.sort();
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              child: Text(
                ideas[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            );
          });
    } else
      return Loading();
  }
}
