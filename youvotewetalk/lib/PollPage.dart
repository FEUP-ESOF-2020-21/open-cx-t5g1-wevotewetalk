import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Schedule.dart';

class PollPage extends StatefulWidget {
  PollPage({Key key}) : super(key: key);

  @override
  _PollPageState createState() => _PollPageState();
}

Widget topicInput() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    child: TextField(
      obscureText: false,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Topics you are interested",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ),
  );
}

class _PollPageState extends State<PollPage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget pollButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          navigateToSchedulePage(context);
        },
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: Colors.indigo,
        splashColor: Colors.white,
        highlightColor: Colors.white,
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Future navigateToSchedulePage(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Schedule(
                  title: 'Schedule',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Page"),
      ),
      body: new Container(
          height: 500.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              new Container(
                child: Text(
                  '\nYour Suggestion\n',
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
              new Container(
                  child: new Column(
                children: <Widget>[
                  topicInput(),
                  pollButton(),
                ],
              ))
            ],
          )), // This trailing comma mak
      // es auto-formatting nicer for build methods.
    );
  }
}
