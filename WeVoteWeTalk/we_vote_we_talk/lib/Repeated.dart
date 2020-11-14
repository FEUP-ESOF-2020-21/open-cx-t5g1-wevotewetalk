import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Idea.dart';


// ignore: must_be_immutable
class Repeated extends StatelessWidget {
  String value;

  Repeated({this.value}){
    print(value);
  }

  bool result = false;


  @override
  Widget build(BuildContext context) {
    print(value);
    final ideas = Provider.of<List<Idea>>(context);
    ideas.forEach((idea) {
      print(idea.name);
      if(idea.name == value)
      {
        result = true;
        return null;
      }
    });
    return null;
  }

}
