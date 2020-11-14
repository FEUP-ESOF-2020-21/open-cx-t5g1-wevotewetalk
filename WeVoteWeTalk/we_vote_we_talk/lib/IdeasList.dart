import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/shared/Loading.dart';
import 'Idea.dart';

class IdeasList extends StatefulWidget {
  List<Idea> themes;

  IdeasList(List<Idea> themes){
    this.themes = themes;
  }

  @override
  _IdeasListState createState() => _IdeasListState(themes);
}

class _IdeasListState extends State<IdeasList> {
  List<Idea> themes;

  _IdeasListState(List<Idea> themes){
    this.themes = themes;
  }

  @override
  Widget build(BuildContext context) {

    final ideas = Provider.of<List<Idea>>(context);
    this.themes = ideas;
    if(ideas != null) {
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
              ),
            );
          }
      );
    }
    else
      return Loading();
  }
}
