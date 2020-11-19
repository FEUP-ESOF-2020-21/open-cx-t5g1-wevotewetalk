import 'package:flutter/material.dart';
import 'Shared/Idea.dart';
import 'TalkJoin.dart';
import 'Brainstorm/IdeasList.dart';

List<Idea> ideasList;

class TalksOverview extends StatefulWidget {
  @override
  _TalksOverviewState createState() => _TalksOverviewState();
}

class _TalksOverviewState extends State<TalksOverview> {
  var talks = new List();

  _TalksOverviewState() {}

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < ideasList.length; i++) {
      if (ideasList[i].name != null) talks.add(ideasList[i].name);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('We Vote We Talk'),
        ),
        body: Center(
            child: ListView(
          shrinkWrap: true,
          children: getListTalks(),
        )));
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
