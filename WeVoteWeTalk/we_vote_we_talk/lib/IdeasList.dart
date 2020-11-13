import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/shared/Loading.dart';
import 'Idea.dart';

class IdeasList extends StatefulWidget {
  @override
  _IdeasListState createState() => _IdeasListState();
}

class _IdeasListState extends State<IdeasList> {
  @override
  Widget build(BuildContext context) {

    final ideas = Provider.of<List<Idea>>(context);
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
