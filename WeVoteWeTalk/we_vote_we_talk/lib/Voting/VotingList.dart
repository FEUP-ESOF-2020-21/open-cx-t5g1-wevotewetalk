import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_vote_we_talk/shared/Loading.dart';
import 'package:we_vote_we_talk/Shared/Idea.dart';
import '../Database.dart';
import '../TalksOverview.dart';

class VotingList extends StatefulWidget {
  @override
  _VotingListState createState() => _VotingListState();
}

class _VotingListState extends State<VotingList> {
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
                          Icon(false? Icons.favorite_outlined : Icons.favorite_border_outlined),
                          onPressed: () async {
                            if(false)
                              await DatabaseService(docID : ideas[index].documentID).updateIdeas(ideas[index].name, ideas[index].votes-1);
                            else
                              await DatabaseService(docID : ideas[index].documentID).updateIdeas(ideas[index].name, ideas[index].votes+1);
                          }
                      ),
                    ),
                  ],
                ),
              )
            );
          });
    } else
      return Loading();
  }

}
