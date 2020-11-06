import 'package:flutter/material.dart';
import 'shared/GenericWidgets.dart';

class Vote extends StatefulWidget {

  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  var themes = new List();
  var likes = new List();

  _VoteState(){
    themes.add("tema1");
    themes.add("tema2");
    themes.add("tema3");
    themes.add("tema4");
    themes.add("tema5");
    themes.add("tema6");
    themes.add("tema7");
    themes.add("tema8");
    themes.add("tema9");
    themes.add("tema10");

    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
    likes.add(false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Vote We Talk'),
      ),
      body: new Column(
          children: [
            Expanded(
                flex: 9,
                child: ListView(
                  children: getListThemes(),

                )
            ),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child:
                    button('Main Menu', navigateBackToMainMenu)
                )
            )
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
      list.add(votingElement(themes[i], likes[i], i));
    }
    return list;
  }

  Widget votingElement(theme, like, i){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          Expanded(
              flex: 9,
              child: Text(
                theme,
                textAlign: TextAlign.center,
              )
          ),
          Expanded(
              flex: 1,
              child: likeIcon(like, i)
          )
        ],
      ),
    );
  }

  Widget likeIcon(like, i) {
    return IconButton(
        icon: Icon(like ? Icons.favorite_outlined : Icons.favorite_border_outlined),
        onPressed: () {
          setState(() {
            likes[i] = !like;
          });
        }
    );
  }
}