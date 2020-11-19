import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Idea.dart';

// ignore: must_be_immutable
class IdeaRepeated extends StatelessWidget {
  String value;

  IdeaRepeated({this.value}) {
    print(value);
  }

  bool result = false;

  @override
  Widget build(BuildContext context) {
    final ideas = Provider.of<List<Idea>>(context);
    ideas.forEach((idea) {
      if (idea.name == value) {
        result = true;
        return null;
      }
    });
    return null;
  }
}
