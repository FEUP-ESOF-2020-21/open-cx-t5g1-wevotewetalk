import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Idea.dart';
import 'IdeasList.dart';
import 'package:we_vote_we_talk/Database.dart';
import 'package:provider/provider.dart';

import 'Repeated.dart';

class Brainstorm extends StatefulWidget {

  @override
  _BrainstormState createState() => _BrainstormState();
}

class _BrainstormState extends State<Brainstorm> {

  List<Idea> themes;

  TextEditingController tecThemeIdea = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Vote We Talk'),
      ),
      body: Column(
          children: [
            Expanded(
                flex: 6,
                child: _buildListBody(context),

            ),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: themeInput()
                        ),
                        Expanded(
                            flex: 2,
                            child: sendButton()
                        ),
                      ],

                    ),
                  ],
                )
            ),
          ]
      ),
    );
  }

  Widget _buildListBody(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().ideas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data.documents);
        }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );

  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final idea = Idea.fromSnapshot(data);

    return Padding(
      key: ValueKey(idea.name),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),

      child: Text(
        idea.name,
        textAlign: TextAlign.center,
      ),
    );
  }





isRepeated(value)
  {
    Repeated aux = Repeated(value: value).build(context);
    return aux.result;
  }

  Widget themeInput() {
    return StreamProvider<List<Idea>>.value(
        value: DatabaseService().ideas,
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: tecThemeIdea,
                decoration: InputDecoration(labelText: 'Your theme idea:'),
                validator: (value) {
                  return value.isEmpty || isRepeated(value) ? 'Enter a new theme idea.' : null;
                },
              ),
            )
        )
    ) ;


  }

  Widget sendButton() {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child:MaterialButton(
          textColor: Colors.white,
          color: Colors.black87,
          child: Text('Send'),
          onPressed: () {
            sendThemeIdea();
          },
          minWidth: 200.0,
          height: 45.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        )
    );
  }

  sendThemeIdea() async {
    if(_formKey.currentState.validate()){
      await DatabaseService().addIdea(tecThemeIdea.text, 0);
    }
  }



}
