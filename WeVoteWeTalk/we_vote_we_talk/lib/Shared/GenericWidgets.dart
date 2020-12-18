import 'package:flutter/material.dart';

Widget button(text, onPressedFunction) {
  return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child:MaterialButton(
        textColor: Colors.white,
        color: Colors.black87,
        child: Text(text),
        onPressed: () {
          onPressedFunction();
        },
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      )
  );
}

Widget closedButton(text) {
  return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child:MaterialButton(
        textColor: Colors.white,
        color: Colors.grey[700],
        child: Text(text),
        onPressed: () {
          //do nothing
        },
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      )
  );
}

Widget blueButton(text, onPressedFunction) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0,
    ),
    child: MaterialButton(
      onPressed: ()  {
        onPressedFunction();
      },
      child: Text(
        text,
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

Widget closedInterface(String stage)
{
  return Scaffold(
      appBar: AppBar(
        title: Text('We Vote We Talk'),
        backgroundColor: Color(0xFF106799),
      ),
      body: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(stage + ' was closed by the Moderator.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('Please return to The main Menu.', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
            ],
          )
      )
  );
}