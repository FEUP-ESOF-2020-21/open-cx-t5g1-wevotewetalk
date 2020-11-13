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

  TextEditingController tecThemeIdea = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Idea>>.value(
      value: DatabaseService().ideas,
      child: Scaffold(
          appBar: AppBar(
            title: Text('We Vote We Talk'),
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: constraints.copyWith(
                      minHeight: constraints.maxHeight,
                      maxHeight: double.infinity,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 300.0,
                            child: IdeasList(),
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: themeInput()
                                    ),
                                    Expanded(
                                        child: sendButton()
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              ),
      )
    );
  }


/*Column(
            children: [
              Expanded(
                  flex: 6,
                  child: ListView(
                    reverse: true,
                    children: getListThemes(),

                  )
              ),
              */

/*
  Future navigateBackToMainMenu() async {
    Navigator.pop(context);
  }

  List<Widget> getListThemes() {
    List<Widget> list = new List();

    for(int i=0; i<themes.length; i++){
      list.add(listElement(themes[i]));
    }
    return list;
  }

  Widget listElement(theme){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: Text(
        theme,
        textAlign: TextAlign.center,
      ),
    );
  }
*/


isRepeated(value)
{
  Repeated aux = Repeated(value: value);
  return aux.result;
}

Widget themeInput() {
  return Padding(
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
  );
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
