import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Idea.dart';

class IdeasList extends StatefulWidget {
  @override
  _IdeasListState createState() => _IdeasListState();
}

class _IdeasListState extends State<IdeasList> {
  @override
  Widget build(BuildContext context) {

    final ideas = Provider.of<List<Idea>>(context);

    print("LENGTH OF IDEAS IS\n");
    print(ideas.length);
    ideas.forEach((idea) {
      print(idea.idea);
    });

    return ListView.builder(
        itemCount: ideas.length,
        itemBuilder: (context,index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: Text(
              ideas[index].idea,
              textAlign: TextAlign.center,
            ),
          );
        }
    );

  }
}
