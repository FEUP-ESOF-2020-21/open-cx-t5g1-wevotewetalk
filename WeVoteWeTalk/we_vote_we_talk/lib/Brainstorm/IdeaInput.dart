import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Shared/Idea.dart';

// ignore: must_be_immutable
class IdeaInput extends StatefulWidget {
  TextEditingController tecThemeIdea;
  var formKey;

  IdeaInput({this.formKey, this.tecThemeIdea});

  @override
  _IdeaInputState createState() => _IdeaInputState(formKey, tecThemeIdea);
}

class _IdeaInputState extends State<IdeaInput> {
  TextEditingController tecThemeIdea;
  var formKey;

  _IdeaInputState(formKey, tecThemeIdea) {
    this.tecThemeIdea = tecThemeIdea;
    this.formKey = formKey;
  }

  @override
  Widget build(BuildContext context) {
    final ideas = Provider.of<List<Idea>>(context);

    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Form(
          key: formKey,
          child: TextFormField(
            controller: tecThemeIdea,
            decoration: InputDecoration(labelText: 'Your theme idea:'),
            validator: (value) {
              return value.isEmpty || isRepeated(value, ideas)
                  ? 'Enter a new theme idea.'
                  : null;
            },
          ),
        ));
  }

  isRepeated(value, ideas) {
    for (int i = 0; i < ideas.length; i++) {
      if (ideas[i].name == value) return true;
    }
    return false;
  }
}
