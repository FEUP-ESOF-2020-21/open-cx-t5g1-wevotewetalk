import 'package:flutter/material.dart';
import '../Shared/Idea.dart';
import 'IdeasList.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:provider/provider.dart';

import 'IdeaInput.dart';

class Brainstorm extends StatefulWidget {
  @override
  _BrainstormState createState() => _BrainstormState();
}

class _BrainstormState extends State<Brainstorm> {
  TextEditingController tecThemeIdea = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Idea>>.value(
        value: DatabaseService().ideas,
        child: Scaffold(
          appBar: AppBar(
            title: Text('We Vote We Talk'),
          ),
          body: Column(children: [
            Expanded(flex: 6, child: IdeasList()),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: IdeaInput(
                                formKey: formKey, tecThemeIdea: tecThemeIdea)),
                        Expanded(flex: 3, child: sendButton()),
                      ],
                    ),
                  ],
                )),
          ]),
        ));
  }

  Widget sendButton() {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child: MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text('Send'),
          onPressed: () {
            sendThemeIdea();
          },
          minWidth: 200.0,
          height: 45.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ));
  }

  sendThemeIdea() async {
    if (formKey.currentState.validate()) {
      await DatabaseService().addIdea(tecThemeIdea.text, 0);
      tecThemeIdea.text = "";
    }
  }
}
