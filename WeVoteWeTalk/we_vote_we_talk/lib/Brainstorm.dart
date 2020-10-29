import 'package:flutter/material.dart';

import 'GenericWidgets.dart';

class Brainstorm extends StatefulWidget {


  @override
  _BrainstormState createState() => _BrainstormState();
}

class _BrainstormState extends State<Brainstorm> {
  var themes = new List();

  TextEditingController tecThemeIdea = new TextEditingController();
  String _themeIdea = "";

  final _formKey = GlobalKey<FormState>();

  _BrainstormState(){
    themes.add("tema1");
    themes.add("tema2");
    themes.add("tema3");
    themes.add("tema4");
    themes.add("tema5");
  }

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
                child: ListView(
                  reverse: true,
                  children: getListThemes(),

                )
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
                    button('Main Menu', navigateBackToMainMenu)
                  ],
                )
            ),
          ]
      ),
    );
  }

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
              return value.isEmpty || themes.contains(value) ? 'Enter a new theme idea.' : null;
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

  sendThemeIdea(){
    if (_formKey.currentState.validate()) {
      setState(() {
        _themeIdea = tecThemeIdea.text;
        themes.insert(0,_themeIdea);
        tecThemeIdea.text = "";
      });
    }
  }

}
