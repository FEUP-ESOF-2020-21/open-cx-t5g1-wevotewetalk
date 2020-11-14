import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Idea.dart';

// ignore: must_be_immutable
class ThemeInput extends StatefulWidget {

  TextEditingController tecThemeIdea;
  var formKey;

  ThemeInput({this.formKey, this.tecThemeIdea});

  @override
  _ThemeInputState createState() => _ThemeInputState(formKey, tecThemeIdea);
}

class _ThemeInputState extends State<ThemeInput> {

  TextEditingController tecThemeIdea;
  var formKey;
  _ThemeInputState(formKey, tecThemeIdea)
  {
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
              return value.isEmpty || isRepeated(value,ideas) ? 'Enter a new theme idea.' : null;
            },
          ),
        )
    );
  }

  isRepeated(value,ideas)
  {
    for(int i = 0; i < ideas.length; i++)
    {
      if(ideas[i].name == value)
        return true;
    }
    return false;
  }

}
