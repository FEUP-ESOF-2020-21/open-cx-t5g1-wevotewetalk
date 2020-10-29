import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PollPage.dart';

class Schedule extends StatefulWidget {
  Schedule({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(
          height: 500.0,
          alignment: Alignment.center,
          child: new Column(
            children: [
              new Container(
                child: Text(
                  '\nSchedule\n',
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                ),
              ),
              new Container(
                  child: new Column(
                children: <Widget>[
                  pollButton('Meeting Link')
                ],
              ))
            ],
          )), // This trailing comma mak
      // es auto-formatting nicer for build methods.
    );
  }

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget pollButton(String txt) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Text(
          txt,
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
}
