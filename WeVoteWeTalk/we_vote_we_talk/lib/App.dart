import 'Wrapper.dart';
import 'Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'User.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return StreamProvider<User>.value(
          value: AuthService().user,
          child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}
