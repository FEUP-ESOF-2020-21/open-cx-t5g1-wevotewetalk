import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Idea.dart';


// ignore: must_be_immutable
class Repeated extends StatelessWidget {
  String value;

  Repeated({this.value});

  bool result = false;


  @override
  Widget build(BuildContext context) {
    print(value);
    final ideas = Provider.of<List<Idea>>(context);
    print(ideas.length);
    if (ideas != null) {
      return ListView.builder(
          itemCount: ideas.length,
          itemBuilder: (context, index) {
            print(ideas[index].name);
            if (ideas[index].name == value)
            {
              result = true;
              return null;
            }
            return null;
          }
      );
    }
    else
    {
      result = true;
      return null;
    }
  }

}
